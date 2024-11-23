require('dotenv').config(); 
const express = require('express');
const bodyParser = require('body-parser');
const userRoutes = require('./routes/userRoutes'); 
const collectionRoutes = require('./routes/collectionRoutes');

const app = express();
app.use(bodyParser.json());
app.use('/users', userRoutes);
app.use('/api', collectionRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});