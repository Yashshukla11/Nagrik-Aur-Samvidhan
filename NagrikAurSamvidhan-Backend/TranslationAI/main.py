from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from transformers import M2M100ForConditionalGeneration, M2M100Tokenizer
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Load Hugging Face model and tokenizer once
repo_id = "facebook/m2m100_418M"
tokenizer = M2M100Tokenizer.from_pretrained(repo_id)
model = M2M100ForConditionalGeneration.from_pretrained(repo_id)


def translate_text(text, target_lang):
    tokenizer.src_lang = "en"
    encoded_text = tokenizer(text, return_tensors="pt")
    generated_tokens = model.generate(
        **encoded_text, forced_bos_token_id=tokenizer.get_lang_id(target_lang))
    translated_text = tokenizer.batch_decode(
        generated_tokens, skip_special_tokens=True)
    return translated_text


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


@app.post("/translate")
async def translate(text: str, target_lang: str):
    try:
        translation = translate_text(text, target_lang)
        return {"translation": translation}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# To run the application use: uvicorn main:app --reload
