import dotenv from 'dotenv';
dotenv.config();

import OpenAI from "openai";
import express from "express";
import cors from 'cors';
import multer from 'multer';

import path from "path";
import fs from "fs";


const uploadDir = './uploads';


// Configurer multer pour le stockage des fichiers
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    // Spécifier le répertoire où les fichiers seront stockés
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    // Renommer le fichier pour éviter les conflits
    cb(null, 'file_'+Date.now() + path.extname(file.originalname));
  }
});

// Créer un middleware pour gérer les fichiers
const upload = multer({ storage: storage });






const openai = new OpenAI({
    organization: "parene",
    apiKey: process.env.API_KEY,
    defaultHeaders: {
    "OpenAI-Beta": "assistants=v2"
  }
});


const app = express();

app.use(express.urlencoded({extended:true}));
app.use(express.json());

import session from 'express-session';

app.use(session({
  secret: 'super-secret-key',       // à personnaliser
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }         // ✅ false en local (dev), true avec HTTPS
}));
  
// // 🌐 CORS
app.use(cors({
    origin: 'http://localhost:5173', // adresse de ton front React
    credentials: true
}));

// app.set('view engine', 'ejs');
app.use(express.static('public'));





// connexion a mysql
import connection from "./db.mjs";


























app.post('/add_msg',upload.single('file'), async (req, res) => {
    let threadId;
    const assistant_id = req.body.assistant_id;
    console.log(assistant_id)
   

    // try {
        // Vérifier si un thread existe en session, sinon créer un nouveau thread
        if (!req.session.threadId) {
            var thread = await openai.beta.threads.create();
            req.session.threadId = thread.id; // Stocker le thread en session
            threadId = thread.id
            console.log('nouveau thread créer', threadId)
        } else {
            threadId = req.session.threadId; // Utiliser le thread existant en session
            console.log('thread existant : ', threadId)

        }
        console.log(threadId)

        // stocker le message dans la bd

        connection.query(
          'INSERT INTO messages(message, sender, _time, id_thread, isFile, id_assistant, mode_assistant) VALUES (?, ?, ?, ?,?,?,?)',
          [req.body.msg, "user", new Date().toISOString(), req.body.threadId, 0,assistant_id, req.body.mode],

        );

        if(req.file){
          connection.query(
            'INSERT INTO messages(message, sender, _time, id_thread, isFile, id_assistant, mode_assistant) VALUES (?, ?, ?, ?, ?,?,?)',
            [req.file.filename, "user", new Date().toISOString(), req.body.threadId, 1,assistant_id, req.body.mode],
  
          );
        }
       
        
        if(req.file){

          const aapl10k = await openai.files.create({
            file: fs.createReadStream('uploads/'+req.file.filename),
            purpose: "assistants",
          });

          const message = await openai.beta.threads.messages.create(
            threadId,
            {
                role: "user",
                content: req.body.msg,
                attachments: [{ file_id: aapl10k.id, tools: [{ type: "file_search" }] }],
            },
          );

        }
        else{
          const message = await openai.beta.threads.messages.create(
            threadId,
            {
                role: "user",
                content: req.body.msg
            }
        );
        }
       


        // Lancer l'Assistant
        const run = await openai.beta.threads.runs.createAndPoll(threadId, {
            assistant_id: assistant_id,
            instructions: "Adresse toi à l'utilisateur en tant que juriste",
        });

        // Vérifier si l'exécution est terminée
        if (run.status !== "completed") {
            return res.status(500).json({ error: "L'IA n'a pas répondu correctement." });
        }

        // Récupérer la réponse de l'IA
        const messages = await openai.beta.threads.messages.list(threadId);
        const lastMessage = messages.data.find(msg => msg.role === "assistant");
        const _time = new Date().toISOString();

        

        if (lastMessage) {
            // stocker le message de l'ia dans la bd
            console.log('lastMessage existe bien')
            const [results] = await connection.query(
              'INSERT INTO messages (message, sender, _time, id_thread, id_assistant, mode_assistant) VALUES (?, ?, ?, ?, ?, ?)',
              [
                lastMessage.content[0].text.value, // Message
                'assistant', // Expéditeur
                _time, // Heure
                req.body.threadId, // ID du thread,
                assistant_id,
                req.body.mode
              ]
            );
          
            console.log('Dernier ID inséré:', results.insertId);
            var response = {
              success: true,
              insertedId: results.insertId,
              response: lastMessage.content,
             
            }
            if(req.file){
              response['filename'] = req.file.filename;
            }
            res.json(response);

        } else {
            res.json({ response: "Pas de réponse de l'IA." });
        }

    // } catch (error) {
    //     console.error("Erreur serveur :", error);
    //     res.status(500).json({ error: "Erreur interne du serveur" });
    // }
});



app.post('/get_threads', async(req, res)=>{
  console.log(req.body.iduser)
  const [rows] = await connection.query(
    'SELECT * FROM threads WHERE id_user = ? ORDER BY id DESC',
    [req.body.iduser]
  );
  console.log(rows);
  res.json({rows:rows})
})



app.post('/get_thread', async(req, res)=>{

 
  let thread = await openai.beta.threads.create();
  req.session.threadId = thread.id; 
  
  // récupérer les messages
  const [rows] = await connection.query(
    'SELECT * FROM messages WHERE id_thread = ?',
    [JSON.parse(req.body.threadId)]
  );
  console.log(rows);

  let latestObj = rows[rows.length - 1];
  console.log(latestObj)
  // alimenter le thread avec les message
  rows.forEach(async (row)=>{
    if(row.isFile){

      const aapl10k = await openai.files.create({
        file: fs.createReadStream('uploads/'+row.message),
        purpose: "assistants",
      });

      await openai.beta.threads.messages.create(
        thread.id,
        {
            role: row.sender,
            content: row.message,
            attachments:[{ file_id: aapl10k.id, tools: [{ type: "file_search" }] }]
        }
      );
    }
    else{
      await openai.beta.threads.messages.create(
        thread.id,
        {
            role: row.sender,
            content: row.message
        }
      );
    }
    
  })



  res.json({rows:rows, id_assistant : latestObj.id_assistant , mode:latestObj.mode_assistant})
})



app.post('/new_thread', async(req, res)=>{
  let {iduser, nameThread} = req.body;

  // before isnerting, check if the name already exist
  let [e] = await connection.query('SELECT * FROM threads WHERE name=?',[nameThread])
  console.log(e)
  console.log(e.length)
  if(e.length != 0){
    res.json({err:true})
  }
  
  else{
    let [results] = await connection.query('INSERT INTO threads(id_user, name) VALUES (?, ?)', 
      [iduser, nameThread]
    )
    // créer un nouveau thread
    let thread = await openai.beta.threads.create();
    req.session.threadId = thread.id; 
  
    // passer un message d'accueil
    await openai.beta.threads.messages.create(
      thread.id,
      {
          role:'assistant',
          content: 'Bonjour, je suis votre assistant juridique spécialisé dans la conversation, comment puis-je vous aider ?'
      }
    );
  
    await connection.query("INSERT INTO messages(message,sender, _time, id_thread, mode_assistant, id_assistant) VALUES (?, ?, ?, ?, ?,?)", 
      ['Bonjour, je suis votre assistant juridique spécialisé dans la conversation, comment puis-je vous aider ?',
        'assistant',
        new Date().toISOString(),
        results.insertId,
        
        "conversation",
        "asst_ufQ7CW20LTyC0Wi22jVOigWN"
      ]
    );



    const [rows] = await connection.query(
      'SELECT * FROM threads WHERE id_user = ? ORDER BY id DESC',
      [req.body.iduser]
    );
  
    res.json({
      success: true,
      insertedId: results.insertId,
      message: 'Bonjour, je suis votre assistant juridique spécialisé dans la conversation, comment puis-je vous aider ?',
      rows:rows,
    });





  }
  



  

})
















app.post('/delete_thread', async(req, res)=>{
    
  let {threadId} = req.body;
  await connection.query('DELETE FROM threads WHERE id = ?', [threadId])    

  await connection.query('DELETE FROM messages WHERE id_thread = ?', [threadId])

  const [rows] = await connection.query(
    'SELECT * FROM threads WHERE id_user = ? ORDER BY id DESC',
    [req.body.iduser]
  );


  res.json({rows:rows})
    
})





app.post('/change_assistant', async(req, res)=>{

  const [results] = await connection.query(
    'INSERT INTO messages(message, sender, _time, id_thread,mode_assistant, id_assistant) VALUES (?, ?, ?, ?, ?, ?)',
    [req.body.msg, "assistant", new Date().toISOString(), req.body.threadId, req.body.mode_assistant, req.body.id_assistant],

  );

  
  await openai.beta.threads.messages.create(
    req.session.threadId,
    {
        role:'assistant',
        content: req.body.msg
    }
  );
  res.json({done:true, id: results.insertedId})

})



const PORT = process.env.PORT || 3000; 

 

app.listen(PORT, ()=>{
    console.log(`App listening to port ${PORT}`);
})