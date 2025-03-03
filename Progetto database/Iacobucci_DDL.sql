-- Elimina tutte le tabelle con vincoli di chiave esterna in cascata
DROP TABLE IF EXISTS visualizzazioni_live CASCADE;
DROP TABLE IF EXISTS chat CASCADE;
DROP TABLE IF EXISTS whispersss CASCADE;
DROP TABLE IF EXISTS notifica CASCADE;
DROP TABLE IF EXISTS transazioni CASCADE;
DROP TABLE IF EXISTS live CASCADE;
DROP TABLE IF EXISTS contenuti CASCADE;
DROP TABLE IF EXISTS relazioni_utente_canale CASCADE;
DROP TABLE IF EXISTS canale CASCADE;
DROP TABLE IF EXISTS utente CASCADE;

-- Elimina i tipi ENUM
DROP TYPE IF EXISTS TIPO_UTENTE CASCADE;
DROP TYPE IF EXISTS TRANSAZIONE CASCADE;
DROP TYPE IF EXISTS RELAZIONE CASCADE;
DROP TYPE IF EXISTS CONTENT CASCADE;


CREATE TYPE TIPO_UTENTE AS ENUM ('guest', 'registrato');
CREATE TYPE TRANSAZIONE AS ENUM ('donazione', 'acquisto');
CREATE TYPE RELAZIONE AS ENUM ('follower', 'sub', 'entrambi');  
CREATE TYPE CONTENT AS ENUM ('vod', 'clip', 'contenuto_extra');  



CREATE TABLE IF NOT EXISTS utente (
    username VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255), 
    data_nascita DATE, 
    telefono VARCHAR(14), -- 14 CIFRE SONO PER GESTIRE LE 4 CIFRE DEL PREFISSO IN AGGIUNTA ALLE 10 NORMALI CHE COMPONGONO UN NUMERO DI TELEFONO
    portafoglio DECIMAL(6,2) DEFAULT 0 ,
    fragile BOOLEAN DEFAULT FALSE, 
    stato TIPO_UTENTE NOT NULL DEFAULT 'guest',
    CHECK (
		(stato = 'guest' AND nome IS NULL AND email IS NULL AND password IS NULL AND data_nascita IS NULL AND telefono IS NULL AND portafoglio = 0 AND fragile = FALSE) 
		OR
		(stato = 'registrato'  AND nome IS NOT NULL AND email IS NOT NULL AND password IS NOT NULL AND data_nascita IS NOT NULL AND telefono IS NOT NULL)
	),
	CHECK(portafoglio >= 0)
);


CREATE TABLE if not exists canale (
  	gestore_canale VARCHAR(255) PRIMARY KEY,
    descrizione VARCHAR(255) DEFAULT '', -- controllo default ''
    N_follower INT DEFAULT 0 NOT NULL,
    N_abbonati INT DEFAULT 0,
    immagine_profilo VARCHAR(255),  
    lista_social VARCHAR(255),
    calendario VARCHAR (255) DEFAULT '', 	-- controllo deafult
	trailer VARCHAR(255) DEFAULT '', 		-- controllo default 
	affiliate BOOLEAN DEFAULT FALSE,	    -- controllo per affiliate (INSERIRE DATI COERENTI); 

	minuti_trasmessi INT DEFAULT 0,
	media_totale_spettatori INT DEFAULT 0,

    FOREIGN KEY (gestore_canale) REFERENCES utente(username),
	CHECK(N_follower >= 0),
	CHECK(minuti_trasmessi >= 0),
	CHECK(media_totale_spettatori >= 0),
	CHECK(N_abbonati >= 0),
	 -- se non si è affiliati non è possibile avere abbonati, per essere affiliati 
	  CHECK(
        (affiliate = FALSE AND N_abbonati IS NULL) OR
        (affiliate = TRUE AND minuti_trasmessi >= 500 AND media_totale_spettatori >= 3 AND N_follower >= 50)
    )
);



CREATE TABLE if not exists relazioni_utente_canale (
	id_relazione SERIAL PRIMARY KEY,
    nome_utente VARCHAR(255) NOT NULL,
    nome_canale VARCHAR(255) NOT NULL,
	tipo_relazione RELAZIONE NOT NULL,
	data_inizio_follow DATE,
    data_fine_follow DATE,
    data_inizio_sub DATE,
    data_fine_sub DATE,
    FOREIGN KEY (nome_utente) REFERENCES utente(username),
    FOREIGN KEY (nome_canale) REFERENCES canale(gestore_canale),
	CHECK(   (tipo_relazione = 'follower' AND data_inizio_sub IS NULL AND data_fine_sub IS NULL AND data_inizio_follow IS NOT NULL) 
		  OR (tipo_relazione = 'sub' AND  data_inizio_follow IS NULL AND data_fine_follow IS NULL AND data_inizio_sub IS NOT NULL )
		  OR (tipo_relazione = 'entrambi' AND data_inizio_sub IS NOT NULL AND data_inizio_follow IS NOT NULL ) 	
		 )
);



CREATE TABLE if not exists contenuti (
	canale_contenuto VARCHAR(255) NOT NULL,
	utente_visitatore VARCHAR(255) NOT NULL,
	rapporto_utente_canale RELAZIONE,
	tipo_contenuto CONTENT NOT NULL,
	collegamento VARCHAR(255), -- link alla clip o al vod 
	durata INT DEFAULT 0 NOT NULL,
	voto INT,
	mi_piace INT DEFAULT 0,  
	commento TEXT,
	PRIMARY KEY(collegamento),
	FOREIGN KEY(canale_contenuto)		REFERENCES canale(gestore_canale),
	FOREIGN KEY(utente_visitatore)		REFERENCES utente(username),
	CHECK((rapporto_utente_canale = 'follower' AND tipo_contenuto != 'contenuto_extra') OR (rapporto_utente_canale <> 'follower' AND voto IS NULL)),
	CHECK(durata >= 0),
	CHECK(voto >= 1 AND voto <= 10)
);


CREATE TABLE if not exists live (
    id_live SERIAL PRIMARY KEY,
    titolo VARCHAR(255) NOT NULL,
    data_inizio TIMESTAMP NOT NULL,
    data_fine TIMESTAMP,
    categoria VARCHAR(100) NOT NULL, 
    durata INT NOT NULL DEFAULT 0,
  	spettatori_live INT DEFAULT 0 NOT NULL,
  	canale_live VARCHAR(255) NOT NULL,
  	ora_inizio TIMESTAMP NOT NULL,
    ora_fine TIMESTAMP,
    FOREIGN KEY (canale_live) REFERENCES canale(gestore_canale),
	CHECK (spettatori_live >= 0),
	CHECK (durata >= 0)
);



CREATE TABLE if not exists visualizzazioni_live(
	id_visualizzazione SERIAL PRIMARY KEY,
	nome_utente VARCHAR(255) NOT NULL,
	tempo_di_visualizzazione INT NOT NULL DEFAULT 0 ,
  	live INT,
  	canale VARCHAR(255) NOT NULL,
  	FOREIGN KEY (nome_utente)	REFERENCES utente(username),
  	FOREIGN KEY (live) 			REFERENCES live(id_live),
  	FOREIGN KEY (canale)		REFERENCES canale(gestore_canale),
	CHECK(tempo_di_visualizzazione >= 0)
);

CREATE TABLE if not exists transazioni(
	id_transazione SERIAL PRIMARY KEY,
  	tipo_transazione TRANSAZIONE NOT NULL, 
  	data_transazione DATE NOT NULL,
  	importo DECIMAL (6,2) NOT NULL,
  	utente_transazione VARCHAR(255) NOT NULL,
  	canale_donazione VARCHAR(255),
  	FOREIGN KEY(utente_transazione)	REFERENCES utente(username),
  	FOREIGN KEY(canale_donazione)	REFERENCES canale(gestore_canale),
	CHECK ( (tipo_transazione = 'acquisto' AND canale_donazione IS NULL) OR (tipo_transazione = 'donazione' AND canale_donazione IS NOT NULL) ),
	CHECK(importo >= 0)
);


CREATE TABLE if not exists whispersss(
	id_whisper SERIAL PRIMARY KEY,
  	mittente VARCHAR(255) NOT NULL,
  	destinatario VARCHAR(255) NOT NULL,
  	contenuto_whispersss TEXT NOT NULL,
  	FOREIGN KEY(mittente)		REFERENCES utente(username),
  	FOREIGN KEY(destinatario)	REFERENCES utente(username)
);


CREATE TABLE if not exists notifica(
	id_notifica SERIAL PRIMARY KEY,
	messaggio_notifica TEXT,
  	canale_mittente VARCHAR(255) NOT NULL,
	utente_destinatario VARCHAR(255) NOT NULL,
	riferimento_live INT NOT NULL,
  	FOREIGN KEY(canale_mittente)		REFERENCES canale(gestore_canale),
	FOREIGN KEY(utente_destinatario)	REFERENCES utente(username),
	FOREIGN KEY(riferimento_live)		REFERENCES live(id_live)	 	
); 


CREATE TABLE if not exists chat (
    id_chat SERIAL PRIMARY KEY,
    id_live INT NOT NULL,
    scommesse TEXT,  
    sondaggi TEXT,   
    comandi TEXT,    
    FOREIGN KEY (id_live) REFERENCES live(id_live)
);


