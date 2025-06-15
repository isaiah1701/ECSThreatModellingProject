import express from 'express';

const app = express();
const PORT = 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.send(`
    <html>
      <head><title>Threat Model App</title></head>
      <body>
        <h1>🛡️ Threat Model Composer</h1>
        <p>Simple threat modeling application</p>
        <p>Status: <strong>Running</strong></p>
        <p>Time: ${new Date().toISOString()}</p>
        <a href="/health">Health Check</a> | 
        <a href="/api">API</a>
      </body>
    </html>
  `);
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', time: new Date().toISOString() });
});

app.get('/api', (req, res) => {
  res.json({ 
    message: 'Threat Model API',
    endpoints: ['/health', '/api'],
    version: '1.0.0'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
