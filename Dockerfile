# MiaoMiao RealSkin 포함된 ComfyUI Docker Image
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel

# ComfyUI 설치
WORKDIR /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install --no-cache-dir -r requirements.txt

# 모델 디렉토리 생성
RUN mkdir -p /workspace/ComfyUI/models/checkpoints

# MiaoMiao RealSkin 모델 복사 (로컬 파일 6.5GB)
WORKDIR /workspace/ComfyUI/models/checkpoints
COPY miaomiaoRealskin_epsV10.safetensors .

# RunPod Handler 설정
WORKDIR /workspace
COPY handler.py /workspace/handler.py

# 실행 명령
CMD ["python", "/workspace/handler.py"]
