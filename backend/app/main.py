from fastapi import FastAPI
app = FastAPI(title="Job Search Backend")

@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.get("/hello")
def hello():
    return {"message": "Hello from backend!"}



