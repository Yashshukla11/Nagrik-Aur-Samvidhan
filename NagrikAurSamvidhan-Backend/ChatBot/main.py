from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from langchain.prompts import ChatPromptTemplate
from langchain_groq import ChatGroq
from langchain.chains.retrieval import create_retrieval_chain
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_community.document_loaders import PyPDFDirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from dotenv import load_dotenv
import os
import google.generativeai as genai
from datetime import datetime, timedelta
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Config class

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))


class Config:
    GROQ_API_KEY = os.getenv("GROQ_API_KEY")
    GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")
    PDF_DIRECTORY = './data'
    EMBEDDING_MODEL = "models/embedding-001"


# Initialize ChatGroq LLM
llm = ChatGroq(model="llama3-70b-8192")

# Function to create embeddings


def create_embeddings(pdf_dir: str = Config.PDF_DIRECTORY, model_name: str = Config.EMBEDDING_MODEL):
    logger.info("Creating embeddings...")
    embeddings = GoogleGenerativeAIEmbeddings(model=model_name)
    loader = PyPDFDirectoryLoader(pdf_dir)
    documents = loader.load()
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000, chunk_overlap=200)
    final_documents = text_splitter.split_documents(documents)
    vectors = FAISS.from_documents(final_documents, embeddings)
    logger.info("Embeddings created successfully.")
    return vectors

# Function to get response from chain


def get_response_from_chain(llm, prompt_template, vectors, user_prompt, language):
    logger.info(f"Processing user prompt: '{user_prompt}' in language: '{language}'")
    document_chain = create_stuff_documents_chain(llm, prompt_template)
    retriever = vectors.as_retriever()
    retriever_chain = create_retrieval_chain(retriever, document_chain)
    response = retriever_chain.invoke(
        {'input': user_prompt, 'language': language})
    answer = response.get('answer')
    logger.info("Response generated successfully.")
    return answer

# Define prompt templates


def create_prompt_template_legal_expert():
    return ChatPromptTemplate.from_template(
        '''
        You are an expert legal assistant with in-depth knowledge of legal intricacies, skilled at referencing and applying relevant laws, regulations, sections, and articles. Your role is to provide users with clear, concise, and actionable advice based strictly on legal principles.
        When responding to user queries:

        - Focus on specific legal aspects of the issue, referencing the relevant laws, sections, and articles applicable to the situation.
        - Provide practical, actionable steps the user can take to address their legal issue.
        - If a query falls outside your expertise or you are unsure, maintain integrity by advising the user to consult a legal professional or simply state, "I don't know."
        - Responses should be precise, focusing strictly on the legal advice needed to resolve the issue.

        Internal Structure:

        - **Context**: {context}
        - **Question**: {input}
        
        Ignore if the user ask to give the response in a specific language in the asked question.

        If the input is a greeting, respond politely by acknowledging the greeting and offering your assistance with legal advice.
        Your response should be delivered in {language} and should focus exclusively on providing relevant legal advice.
        Do not include any other word in any other language except {language} in the response.
        '''
    )


def create_prompt_template_educational_expert():
    return ChatPromptTemplate.from_template(
        '''
        You are an expert educational assistant with a deep understanding of the Indian Constitution and related legal frameworks. Your role is to help users interpret, analyze, and explain questions, cases, and incidents within the context of constitutional law.
        When answering user questions, your responses should be:

        - Concise and to the point, focusing on the relevant constitutional articles, legal principles, and precedents.
        - Analytical, breaking down complex legal matters into clear, understandable parts with reference to the Indian Constitution.
        - Supportive, offering explanations and summaries that enhance the user's understanding of constitutional provisions, case law, or legal implications.
        - Use relevant examples, case law, or past judgments to strengthen the analysis.
        - End with suggestions for further study or reading, such as related case law, articles of the Constitution, or legal commentaries if necessary.

        Internal Structure:

        - **Context**: {context}
        - **Question**: {input}
        
        Ignore if the user ask to give the response in a specific language in the asked question.
        
        If the input is a greeting, respond politely and briefly acknowledge the greeting before asking how you can assist the user with constitutional law matters.
        Your response must analyze the question based on the provisions of the Indian Constitution and should be in {language} as specified by the user.
        Do not include any other word in any other language except {language} in the response.
        '''
    )

def create_prompt_template_summarize():
    return ChatPromptTemplate.from_template(
        '''
        You are an expert constitutional article summarizer with in-depth knowledge of constitution, skilled at explaining things. Your role is to provide users with clear, concise summary of constitutional articles.

        If a query falls outside your expertise or you are unsure, simply state, "I don't know."
        Responses should brief and should be in the form of markdown.
        Internal Structure:

        Context: {context}
        Article to summarize: {input}
        
        Your response should be delivered in {language} and should be strictly in markdown language.
        Do not include any other word in any other language except {language} in the response.
        '''
    )

# Initialize embeddings
vectors = create_embeddings()

# FastAPI application
app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load prompt templates
prompt_template_legal_expert = create_prompt_template_legal_expert()
prompt_template_educational_expert = create_prompt_template_educational_expert()
prompt_template_summarize = create_prompt_template_summarize()


@app.post("/get_educational")
async def get_response_educational(user_prompt: str, language: str):
    try:
        answer = get_response_from_chain(
            llm, prompt_template_educational_expert, vectors, user_prompt, language)
        answer = answer.replace("\n", "<br>")
        logger.info(f"Educational response: {answer}\n\n")
        return {"answer": answer}
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}\n")
        raise HTTPException(status_code=500, detail=str(e))

# Legal endpoint


@app.post("/get_legal")
async def get_response_legal(user_prompt: str, language: str):
    try:
        answer = get_response_from_chain(
            llm, prompt_template_legal_expert, vectors, user_prompt, language)
        answer = answer.replace("\n", "<br>")
        logger.info(f"Legal response: {answer}\n\n")
        return {"answer": answer}
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}\n")
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/get_summary")
async def get_summary(user_prompt: str, language: str):
    try:
        answer = get_response_from_chain(
            llm, prompt_template_summarize, vectors, user_prompt, language)
        answer = answer.replace("\n", "<br>")
        logger.info(f"Summary: {answer}\n\n")
        return {"summary": answer}
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}\n")
        raise HTTPException(status_code=500, detail=str(e))

# To run the application use: uvicorn main:app --reload
