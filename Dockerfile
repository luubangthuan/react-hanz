# Sử dụng Node.js image để build ứng dụng
FROM node:18 AS build

# Tạo thư mục làm việc trong container
WORKDIR /app

# Copy package.json và package-lock.json vào container
COPY package.json package-lock.json ./

# Cài đặt các phụ thuộc của dự án
RUN npm install

# Copy toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng React
RUN npm run build

# Sử dụng Nginx để phục vụ ứng dụng React
FROM nginx:alpine

# Copy build của ứng dụng React vào thư mục phục vụ của Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose cổng 80
EXPOSE 80

# Chạy Nginx trong container
CMD ["nginx", "-g", "daemon off;"]
