FROM python:3.8
# https://hub.docker.com/_/python 의 3.8 태그를 가진 이미지를 베이스로 사용
ENV PYTHONUNBUFFERED=1
# 환경 변수 "PYTHONUNBUFFERED"를 1 (True)로 설정
# stdout이 buffer을 거치지 않고 바로 나오도록 설정
# 잘 모르겠으면 대충 "파이썬은 이렇게 하는거구나" 하시면 됩니다 :)
RUN mkdir /app
# Docker 이미지 안에 app이라는 폴더 생성
WORKDIR /app
# 이제부터 모든 명령은 /app 폴더를 기준으로 실행
COPY . /app
# 현재 폴더(.)를 /app으로 복사 
RUN pip install -r requirements.txt
# requirements.txt 파일 내에 있는 패키지들을 Docker 이미지 내에 설치
RUN python manage.py collectstatic --noinput
# static files 모으기
EXPOSE 8000
# 이 앱은 포트 8000번에서 듣는다는 내용
# 실제로 하는 기능은 없음

ENTRYPOINT ["/usr/local/bin/python"]
# 도커 컨테이너 실행시 실행될 프로그램
CMD ["-m", "gunicorn", "config.wsgi", "-b", "0.0.0.0:8000"]
# 도커 컨테이너 실행시 실행될 프로그램에게 줄 추가적인 명령
# 실제로는 /usr/local/bin/python -m gunicorn config.wsgi -b 0.0.0.0:8000 실행
