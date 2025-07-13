# 1. Use official Node.js LTS image
FROM node:18

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# 4. Copy the rest of the project files
COPY . .

# 5. Expose the port the app runs on
EXPOSE 3000

# 6. Start the app
CMD ["npm", "start"]
