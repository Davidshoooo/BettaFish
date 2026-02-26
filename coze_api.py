"""
Coze（扣子）回调用 FastAPI 极简 Web 骨架。
预留 POST /api/analyze 接口，供后续对接 Coze 工作流。
"""

from fastapi import FastAPI

app = FastAPI(
    title="BettaFish Coze API",
    description="供 Coze 调用的分析接口",
    version="0.1.0",
)


@app.get("/")
async def root():
    """健康检查 / 根路径."""
    return {"status": "ok", "service": "BettaFish Coze API"}


@app.post("/api/analyze")
async def analyze():
    """
    预留的 Coze 分析接口。
    后续可在此接收 Coze 请求体，调用项目内分析逻辑并返回结果。
    """
    # TODO: 解析请求体、调用分析引擎、返回结构化结果
    return {"message": "analyze endpoint ready", "data": None}
