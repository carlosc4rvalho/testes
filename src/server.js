const express = require('express');
const app = express();
const userRoutes = require('./routes/product/userRoutes');
const productRoutes = require('./routes/product/productRoutes');
const corsMiddleware = require('./middlewares/corsMiddleware');
const authMiddleware = require('./middlewares/authMiddleware');
const errorMiddleware = require('./middlewares/errorMiddleware');
const loggerMiddleware = require('./middlewares/loggerMiddleware');
require('dotenv').config();

app.use(corsMiddleware);
app.use(loggerMiddleware);
app.use(express.json());

app.use('/api/users', userRoutes);

app.use('/api/products', authMiddleware, productRoutes);

app.use('/api/products', productRoutes);

app.use(errorMiddleware);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
