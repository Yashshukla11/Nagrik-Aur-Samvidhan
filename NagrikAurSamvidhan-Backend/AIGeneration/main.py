import logging
from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from langchain_community.document_loaders import PyPDFDirectoryLoader, UnstructuredURLLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from dotenv import load_dotenv
import os
import google.generativeai as genai
from datetime import datetime, timedelta
import requests
import json
import re
import random
from pymongo import MongoClient
from bson import ObjectId

# Set up logging
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                    filename='app.log',
                    filemode='a')
logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()

# Configure Google API
genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))

# Initialize FastAPI app
app = FastAPI()

# Initialize MongoDB client
try:
    mongo_client = MongoClient(os.getenv("MONGODB_URI"))
    db = mongo_client["nagrik_aur_samvidhan"]
    case_studies_collection = db["casestudies"]
    questions_collection = db["questions"]
    logger.info("Successfully connected to MongoDB")
except Exception as e:
    logger.error(f"Failed to connect to MongoDB: {e}")
    raise

# Load and process PDF documents


def load_and_process_pdfs():
    try:
        logger.info("Starting to load and process PDFs")
        loader = PyPDFDirectoryLoader("data/")
        documents = loader.load()
        text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents(documents)

        embeddings = GoogleGenerativeAIEmbeddings(model="models/embedding-001")
        vector_store = FAISS.from_documents(splits, embeddings)
        logger.info("Successfully loaded and processed PDFs")
        return vector_store
    except Exception as e:
        logger.error(f"Error in load_and_process_pdfs: {e}")
        raise


# Load vector store at startup
try:
    vector_store = load_and_process_pdfs()
except Exception as e:
    logger.error(f"Failed to load vector store: {e}")
    vector_store = None

# Function to insert a question into the questions collection


def insert_question(question_data):
    try:
        question_data['type'] = 'CaseStudy'
        # Default difficulty, adjust as needed
        question_data['difficulty'] = 'Prarambhik'
        result = questions_collection.insert_one(question_data)
        return str(result.inserted_id)
    except Exception as e:
        logger.error(f"Failed to insert question into MongoDB: {e}")
        raise

# Function to insert a case study into the case_studies collection


def insert_case_study(case_study_data):
    try:
        result = case_studies_collection.insert_one(case_study_data)
        return str(result.inserted_id)
    except Exception as e:
        logger.error(f"Failed to insert case study into MongoDB: {e}")
        raise


@app.get("/generate_case_study")
async def get_news(request: Request, query: str):
    logger.info(
        f"Received request to generate case study for query: {query}")
    url = 'https://newsapi.org/v2/everything'
    now = datetime.now()
    ten_days_ago = now - timedelta(days=10)
    params = {
        'q': f'{query}'.format(query=query),
        'from': ten_days_ago.strftime('%Y-%m-%d'),
        'to': now.strftime('%Y-%m-%d'),
        'pageSize': 50,
        'apiKey': os.getenv('NEWS_API_KEY')
    }

    # Modify parameters based on query parameters from the request
    for key in params.keys():
        if key in request.query_params:
            params[key] = request.query_params[key]

    # Make the GET request to the external API
    logger.info(f"Making request to News API with params: {params}")
    response = requests.get(url, params=params)

    # Check if the request was successful
    if response.status_code != 200:
        logger.error(f"Failed to fetch news. Status code: {
                     response.status_code}")
        return JSONResponse(status_code=response.status_code, content={"error": "Failed to fetch news"})

    # Parse the JSON response
    data = response.json()

    # Ensure there are articles in the response
    if 'articles' not in data or not data['articles']:
        logger.warning("No articles found in the API response")
        return JSONResponse(status_code=404, content={"error": "No articles found"})

    # words = ["murder", "rape", "violence", "harassment", "theft", "assault", "kidnapping", "rights violation",
    #          "fundamental rights", "constitution", "fundamental duties", "state policies", "disputes"]
    # filteredArticles = [article for article in data['articles'] if any(
    #     word in article["title"].lower() for word in words)]

    # if not filteredArticles:
    #     logger.warning("No relevant articles found after filtering")
    #     return JSONResponse(status_code=404, content={"error": "No relevant articles found"})

    # print(filteredArticles)
    selectedData = random.choice(data['articles'])
    logger.info(f"Selected article: {selectedData['title']}")

    # Extract the URL from the selected article
    url_data = selectedData['url']

    # Load the news data
    logger.info(f"Loading news data from URL: {url_data}")
    loader = UnstructuredURLLoader(urls=[url_data])
    news_data = loader.load()[0]
    news_text = news_data.page_content

    # Retrieve relevant context from the vector store
    logger.info("Retrieving relevant context from vector store")
    relevant_docs = vector_store.similarity_search(news_text, k=3)
    context = "\n".join([doc.page_content for doc in relevant_docs])

    model = genai.GenerativeModel('gemini-1.5-flash')

    case_study_prompt = f"""You are an AI simulating a human who crafts engaging and interactive case studies based on real news events.
    These case studies should delve into the Indian Constitution, specifically highlighting instances where fundamental rights and laws have been violated.
    Your task is to integrate relevant data and legal aspects from the Constitution and provide detailed analysis without summarizing the case study.
    Ensure the case study is immersive, guiding the reader through an interactive exploration of the situation, encouraging critical thinking,
    and prompting discussion on the constitutional violations involved.

    Use the following news article and additional context to create the case study:

    News Article: {news_text}

    Additional Context: {context}

    Create an engaging and interactive case study based on this information. Also, provide a title for the case study.

    Return the response in the following format:
    {{
      "title": "Title of the case study",
      "description": "Detailed case study description"
    }}
    """

    logger.info("Generating case study content")
    case_study_response = model.generate_content(case_study_prompt)

    case_study_data = re.sub(
        r'^```json\s*|\s*```$', '', case_study_response.text.strip())

    try:
        case_study_data = json.loads(case_study_data)
    except json.JSONDecodeError as e:
        print(case_study_data)
        logger.error(f"JSON decoding error for case study data: {e}")
        return JSONResponse(status_code=500, content={"error": "Failed to parse case study data"})

    case_study_text = case_study_data["description"]

    # Retrieve relevant context from the vector store
    logger.info("Retrieving relevant context for questions")
    relevant_docs = vector_store.similarity_search(case_study_text, k=3)
    context = "\n".join([doc.page_content for doc in relevant_docs])

    # Create the prompt for question generation
    prompt = f"""Based on the following case study and additional context about the Indian Constitution, generate 5 multiple-choice questions.
    Each question should test understanding of constitutional concepts, rights, or laws relevant to the case study.

    Case Study: {case_study_text}

    Additional Context: {context}

    Generate 5 questions in the following JSON format:
    [
      {{
        "question": "What is the question?",
        "options": [
          "Option A donot include 'A'",
          "Option B donot include 'B'",
          "Option C donot include 'C'",
          "Option D donot include 'D'"
        ],
        "correctOption": "The correct option donot include 'A/B/C/D'",
        "hint": "A brief hint to guide the answer",
        "explanation": "A detailed explanation of the correct answer and its relevance to the case study or constitutional concept."
      }},
      // ... (4 more questions)
    ]

    Ensure that the questions are diverse, covering different aspects of the case study and constitutional concepts. The options should be plausible but with only one correct answer.
    """

    # Generate the questions using Google's GenerativeAI model
    logger.info("Generating questions")
    response = model.generate_content(prompt)

    # Extract the content from the generated response
    questions_text = response.text

    questions_text = re.sub(r'^```json\s*|\s*```$',
                            '', questions_text.strip())

    try:
        questions_text = json.loads(questions_text)
    except json.JSONDecodeError as e:
        print(questions_text)
        logger.error(f"JSON decoding error for questions data: {e}")
        return JSONResponse(status_code=500, content={"error": "Failed to parse questions data"})

    question_ids = []
    for question in questions_text:
        question_id = insert_question(question)
        question_ids.append(ObjectId(question_id))

    case_study_data = {
        "title": case_study_data["title"],
        "description": case_study_data["description"],
        "questions": question_ids,
        "duration": 60,
        "totalQuestions": len(question_ids),
        "difficulty": "Prarambhik",
        "image": selectedData['urlToImage'],
        "url": selectedData['url']
    }

    # Insert the case study
    case_study_id = insert_case_study(case_study_data)

    # Prepare the response
    final_response = {
        **case_study_data,
        "_id": case_study_id,
        # Convert ObjectIds to strings for JSON response
        "questions": [str(q_id) for q_id in question_ids]
    }

    return JSONResponse(content=final_response)

if __name__ == "__main__":
    import uvicorn
    logger.info("Starting the FastAPI application")
    uvicorn.run(app, host="0.0.0.0", port=8000)
