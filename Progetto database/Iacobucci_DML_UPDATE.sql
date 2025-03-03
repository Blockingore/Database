-- utente vota un contenuto (
UPDATE contenuti 
SET voto = 6 
WHERE canale_contenuto = 'tumblurr'
    AND utente_visitatore = 'jfaso'
    AND collegamento = 'https://clip_link.com/3';


-- REGISTRAZIONE UTENTE 
INSERT INTO utente(username, nome, email, password, data_nascita, telefono, portafoglio, fragile, stato)
VALUES( 'essok', 'aurelien essok', 'ilpiumattoditutti@gmail.com' ,  'dfveifi1234', '1996-07-30', '+391254762146', 0.00, FALSE, 'registrato' );

-- CREAZIONE CANALE POST REGISTRAZIONE UTENTE 
INSERT INTO canale(gestore_canale, descrizione, N_follower, N_abbonati, immagine_profilo, lista_social, calendario, trailer, affiliate, minuti_trasmessi, media_totale_spettatori)
VALUES('aurelien', 'sono pazzo', 0, NULL, 'https://www.imageLink.com/aurelien', 'https://www.instagram.com/le_babel', ' ', ' ', FALSE, 0, 0);

-- CREAZIONE NUOVA LIVE 
INSERT INTO live(id_live, titolo, data_inizio, data_fine, categoria, durata, spettatori_live, canale_live, ora_inizio, ora_fine)
VALUES(6, 'Torneo videogiochistico', '2024-08-10', '2024-08-11', 'gaming', 200, 150,  'tumblurr', '2024-08-10 21:00:00', '2024-08-11 03:00:00');


-- INVIO NOTIFICA DOPO CREAZIONE DI LIVE 
INSERT INTO notifica(messaggio_notifica, canale_mittente, utente_destinatario, riferimento_live)
VALUES('Entra per vedere il più grande torneo di tutti i tempi', 'tumblurr', 'luca_jake', 6);


-- AGGIUNTA CHAT DELLA LIVE CREATA 
INSERT INTO chat(id_live, scommesse, sondaggi, comandi)
VALUES(6, 'Vinco il torneo? SI/NO ', 'Con quale gioco iniziamo? 1-Fifa; 2-Fall Guys;', '!prime, !sub, !watchtime');


-- AGGIUNTA CONTENT A 'CONTENUTI' 
INSERT INTO contenuti(canale_contenuto, utente_visitatore, rapporto_utente_canale, tipo_contenuto, collegamento, durata, voto, mi_piace)
VALUES('tumblurr', 'luca_jake', 'entrambi', 'clip', 'https://www.clipLink.com/234', 2, 8, 20);


-- INIZIO NUOVA RELAZIONE 
INSERT INTO relazioni_utente_canale(nome_utente, nome_canale, tipo_relazione, data_inizio_follow, data_fine_follow, data_inizio_sub, data_fine_sub)
VALUES('essok', 'therealmarzaa', 'entrambi', '2024-09-01', NULL, '2024-09-01', NULL);

-- NUOVA TRANSAZIONE (es: donazione) 
INSERT INTO transazioni(id_transazione, tipo_transazione, data_transazione, importo, utente_transazione, canale_donazione)
VALUES(6, 'donazione', '2024-01-06', 10, 'azen_the_red_panda', 'therealmarzaa');



-- NUOVO WHISPERSSSSS 
INSERT INTO whispersss(mittente, destinatario, contenuto_whispersss)
VALUES('tumblurr', 'therealmarzaa', 'è nato un riccone');


-- calcolo classifica (top10) degli streamer più seguiti 
SELECT * 
FROM CANALE 
ORDER BY N_follower DESC 
LIMIT 10;


-- calcolo media dei like dei contenuti esempio therealmarzaa 
SELECT ROUND(AVG(mi_piace), 2) AS media_mi_piace
FROM contenuti
WHERE canale_contenuto = 'therealmarzaa';
/*WHERE canale_contenuto = ?;*/


-- classifica contenuti più votati esempio therealmarzaa 
SELECT ROUND(AVG(voto), 2) AS media_voti
FROM contenuti
WHERE canale_contenuto = 'therealmarzaa';



-- rimozione commenti offensivi 
DELETE * 
FROM visualizzazioni_live
WHERE commento = '%parolabannabile%';





