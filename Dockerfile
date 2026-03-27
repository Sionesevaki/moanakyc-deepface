FROM serengil/deepface:latest

# Pre-bake model weights into the image.
# The upstream serengil/deepface_models GitHub repo was deleted (2026-03),
# so runtime downloads fail. Both deepface and retina-face skip the download
# if the file already exists at the expected path.
#
# Weight checksums (md5):
#   facenet512_weights.h5  8ba7c608dacbb4d4b001b7dbae0c5d40  (94 MB)
#   retinaface.h5          345a2e2265a14ccc8f1e3cfbd21683e1  (114 MB)
COPY weights/facenet512_weights.h5 /root/.deepface/weights/facenet512_weights.h5
COPY weights/retinaface.h5 /root/.deepface/weights/retinaface.h5

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD python -c "import requests; r=requests.get('http://localhost:5000/'); exit(0 if r.ok else 1)"
