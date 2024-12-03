# 베이스 이미지로 Nginx 사용
FROM nginx:1.21

# 사용자 정의 HTML 파일 복사
COPY ./index.html /usr/share/nginx/html/index.html

# 기본 Nginx 설정 유지
EXPOSE 80

