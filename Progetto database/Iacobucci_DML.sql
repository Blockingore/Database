-- registrazione di un utente 'registrato' e visita da parte di guest
INSERT INTO utente (username, nome, email, password, data_nascita, telefono, portafoglio, fragile, stato)
VALUES 
('tumblurr', 'Gianpiango Sbocco', 'gianpiango.sbocco@hotmail.it', 'password123', '1990-05-12', '+391234514890', 50.00, FALSE, 'registrato'),
('dariomoccia', 'Catone Luca', 'luca.catone@yahoo.it', 'securePass!', '1985-10-22', '+391234567891', 75.50, FALSE, 'registrato'),
('therealmarzaa', 'Francesco Marzano', 'buisnessmarzaa@gmail.com', 'password321', '1993-07-15', '+396347567892', 20.75, TRUE, 'registrato'),
('luca_jake', 'Luca Iacobucci', 'luca.iacobuccci@hotmail.it', 'password888', '1990-05-12', '+391234201490', 50.00, FALSE, 'registrato'),
('azen_the_red_panda', 'Andrija Jovic', 'andrija.jovic@yahoo.it', 'safessPass!', '1985-10-22', '+391843667891', 75.50, FALSE, 'registrato'),
('jfaso', 'Lorenzo Fasano', 'lorenzofasano@gmail.com', 'password555', '1993-07-15', '+391230147892', 20.75, TRUE, 'registrato'),
('123456', NULL, NULL, NULL, NULL, NULL, 0.00, FALSE, 'guest'),
('142526', NULL, NULL, NULL, NULL, NULL, 0.00, FALSE, 'guest');


-- creazione di un nuovo canale, che viene creato e associato al momento della registrazione di un utente fatta eccezione per i guest
INSERT INTO canale (gestore_canale, descrizione, N_follower, N_abbonati, immagine_profilo, lista_social, calendario, trailer, affiliate, minuti_trasmessi, media_totale_spettatori)
VALUES 
('tumblurr', 'Provo a portre una nuova visione di Cod in italia', 1000, 100, 'https://link_to_image.com/profile1', 'https://instagram.com/blurs7', 'https://calendar_link.com/blur', 'https://trailer_link.com/blur', TRUE, 670, 40),
('dariomoccia', 'Canale divertente e appasionante', 850, 75, 'https://link_to_image.com/profile2', 'https://twitter.com/dario', 'https://calendar_link.com/dario', 'https://trailer_link.com/dario', TRUE, 570, 35),
('therealmarzaa', 'semplicemente the magister!', 950, 85, 'https://link_to_image.com/profile3', 'https://x.com/marza', 'https://calendar_link.com/marza', 'https://trailer_link.com/marza', TRUE, 600, 47),
('luca_jake', ' ', 0, NULL, 'https://link_to_image.com/luca_jake', 'https://instagram.com/jake', ' ', ' ', FALSE, 0, 0),
('azen_the_red_panda', ' ', 2, NULL, 'https://link_to_image.com/azen', 'https://twitter.com/azen', ' ', ' ', FALSE, 23, 1),
('jfaso', ' ', 0, NULL, 'https://link_to_image.com/jfaso', 'https://x.com/marza', ' ', ' ', FALSE, 0, 0);


-- traccia delle relazioni tra utenti e canali
INSERT INTO relazioni_utente_canale (nome_utente, nome_canale, tipo_relazione, data_inizio_follow, data_fine_follow, data_inizio_sub, data_fine_sub)
VALUES 
('luca_jake', 'tumblurr', 'entrambi', '2024-01-01', NULL, '2024-01-10', NULL),
('azen_the_red_panda', 'dariomoccia', 'sub', NULL, NULL, '2024-02-01', NULL),
('jfaso', 'tumblurr', 'follower', '2024-03-01', NULL, NULL, NULL),
('jfaso', 'therealmarzaa', 'entrambi', '2024-04-01', NULL, '2024-06-04', NULL),
('azen_the_red_panda', 'therealmarzaa', 'follower', '2024-05-10', NULL, NULL, NULL);



-- contenuti canali e visite utenti
INSERT INTO contenuti (canale_contenuto, utente_visitatore, rapporto_utente_canale, tipo_contenuto, collegamento, durata, voto, mi_piace, commento)
VALUES 
('tumblurr', 'luca_jake', 'entrambi', 'vod', 'https://vod_link.com/1', 90, 8, 35, 'Bella live!' ),
('dariomoccia', 'azen_the_red_panda', 'sub', 'clip', 'https://clip_link.com/1', 1, 4, 62, 'Mi sono proprio divertito'),
('therealmarzaa', 'jfaso', 'entrambi', 'contenuto_extra', 'https://cnt_extra.com/3', 75, 6, 71, 'Devo assolutamente recuperare il vod, sono entrato tardi!'),
('tumblurr', 'jfaso', 'follower', 'clip', 'https://clip_link.com/3', 3, 10, 21, 'Che divertimento'),
('therealmarzaa', 'azen_the_red_panda', 'follower', 'vod', 'https://vod_link.com/3', 45, 5, 23, 'Ti seguo dal fortnite +18');


-- creazione di una Live
INSERT INTO live (id_live, titolo, data_inizio, data_fine, categoria, durata, spettatori_live, canale_live, ora_inizio, ora_fine)
VALUES 
(1,'Iniziamo TLOU2', '2024-09-02 10:00:00', '2024-09-02 12:30:00', 'Gaming', 150, 175, 'therealmarzaa', '2024-09-02 10:00:00', '2024-09-02 12:30:00'),
(2,'Unboxing posta', '2024-09-04 09:00:00', '2024-09-04 10:30:00', 'Quattro chiacchiere', 90, 100, 'tumblurr', '2024-09-04 09:00:00', '2024-09-04 10:30:00'),
(3,'OLIMPO DI TWITCH', '2024-09-01 14:00:00', '2024-09-01 16:00:00', 'Quattro chiacchiere', 120, 250, 'dariomoccia', '2024-09-01 14:00:00', '2024-09-01 16:00:00'),
(4,'Cooking Live', '2024-09-03 18:00:00', '2024-09-03 19:45:00', 'Food', 105, 130, 'therealmarzaa', '2024-09-03 18:00:00', '2024-09-03 19:45:00'),
(5,'Reactions youtube', '2024-09-05 14:30:00', '2024-09-05 15:15:00', 'Quattro chiacchiere', 45, 50, 'tumblurr', '2024-09-05 14:30:00', '2024-09-05 15:15:00');


-- traccia delle visualizzazioni delle live sia dei guest sia degli utenti registrati 
INSERT INTO visualizzazioni_live (nome_utente, tempo_di_visualizzazione, canale)
VALUES 
('luca_jake', 90, 'tumblurr'),
('azen_the_red_panda', 120, 'dariomoccia'),
('jfaso', 75, 'therealmarzaa');


-- INVIO NOTIFICA
INSERT INTO notifica (messaggio_notifica, canale_mittente, utente_destinatario, riferimento_live)
VALUES 
('Oggi live incredibile', 'therealmarzaa', 'luca_jake', 1),
('Problema sorto?', 'tumblurr', 'jfaso', 2),
('Live con ospiti speciali!', 'dariomoccia', 'azen_the_red_panda', 3),
('Se entri sei un grande', 'therealmarzaa', 'jfaso', 4),
('CORRI', 'tumblurr', 'azen_the_red_panda', 5);


-- storico delle chat
INSERT INTO chat (id_live, scommesse, sondaggi, comandi)
VALUES 
(1,'Scommessa su chi vince', 'Qual è il miglior gioco?', '!comandi, !sub, !prime, !whatchtime'),
(2,'Scommessa sul tempo', 'Il miglior linguaggio di programmazione?', '!comandi, !sub, !prime, !betterttv'),
(3,'Scommessa sulla ricetta', 'Qual è il miglior ingrediente?', '!comandi, !sub, !prime, !7tv'),
(4,'Scommessa sul viaggio', 'La destinazione preferita?', '!comandi, !sub, !prime'),
(5,'Scommessa sul gadget', 'Il miglior dispositivo?', '!comandi, !sub, !prime, !whatchtime');

-- storico tansazioni
INSERT INTO transazioni (id_transazione, tipo_transazione, data_transazione, importo, utente_transazione, canale_donazione)
VALUES 
(1,'acquisto', '2024-01-01', 49.99, 'jfaso', NULL),
(2,'donazione', '2024-01-02', 25.00, 'jfaso', 'therealmarzaa'),
(3,'acquisto', '2024-01-03', 29.99, 'luca_jake', NULL),
(4,'donazione', '2024-01-04', 15.50, 'luca_jake', 'tumblurr'),
(5,'acquisto', '2024-01-05', 19.99, 'azen_the_red_panda', NULL);

--storico whispers
INSERT INTO whispersss (mittente, destinatario, contenuto_whispersss)
VALUES 
('jfaso', 'luca_jake', 'Ciao, come va?'),
('luca_jake', 'jfaso', 'Tutto bene, grazie!'),
('luca_jake', 'azen_the_red_panda', 'Letsgonski, è il solo e unico modo'),
('therealmarzaa', 'tumblurr', 'Problema fratellone?'),
('azen_the_red_panda', 'luca_jake', 'Mr No! No! Non è l unico modo');


