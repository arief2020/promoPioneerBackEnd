# FROM node:18-alpine3.19

# WORKDIR /app

# COPY package*.json .

# RUN npm install

# COPY . .

# EXPOSE 8080

# CMD ["npm", "run", "docker"]

# Gunakan image Node.js sebagai basis
FROM node:18-alpine3.19

# Tentukan direktori kerja dalam container
WORKDIR /app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Instal dependensi
RUN npm install

# Salin sisa kode aplikasi
COPY . .

# Pastikan prisma client dihasilkan
RUN npx prisma generate

# Expose port yang digunakan aplikasi (misalnya, 3000)
EXPOSE 8080

# Jalankan aplikasi
CMD ["npm", "run", "start"]