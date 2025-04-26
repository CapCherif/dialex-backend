-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 11 avr. 2025 à 20:20
-- Version du serveur : 8.3.0
-- Version de PHP : 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `dialex`
--

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `sender` varchar(20) NOT NULL,
  `_time` varchar(40) NOT NULL,
  `id_thread` int NOT NULL,
  `isFile` int NOT NULL DEFAULT 0,
  `mode_assistant` varchar(100) NOT NULL,
  `id_assistant` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_thread` (`id_thread`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `message`, `sender`, `_time`, `id_thread`, `isFile`, `mode_assistant`, `id_assistant`) VALUES
(105, 'Bonjour, je suis votre assistant juridique spécialisé dans la conversation, comment puis-je vous aider ?', 'assistant', '2025-04-11T14:56:07.823Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(107, 'Enchanté ! Je suis ton assistant rédacteur. Que tu aies besoin d\'un texte pro, créatif ou personnel, \n        je peux t\'aider à rédiger avec style et précision. Dis-moi ce que tu veux écrire !\n    ', 'assistant', '2025-04-11T14:56:45.783Z', 29, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(108, 'quel est ton rôle en tant qu\'assistant ?', 'user', '2025-04-11T14:57:09.515Z', 29, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(109, 'Cher justiciable, je suis un assistant numérique conçu pour vous guider et vous informer, tout particulièrement sur des points juridiques. Mon rôle consiste à fournir des explications, des éclaircissements et des pistes de réflexion au sujet de questions juridiques, toujours dans le respect du cadre légal applicable. Je peux, par exemple, vous aider à mieux comprendre un contrat, à identifier des lois ou des règlements pertinents ou à répondre à des interrogations fondamentales sur vos droits et obligations. Cependant, il est important de rappeler que mes réponses ne valent pas un avis juridique personnalisé : si vous avez besoin d’une expertise approfondie ou d’une représentation, je vous recommande de consulter un professionnel du droit adapté à votre situation.', 'assistant', '2025-04-11T14:57:29.054Z', 29, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(110, 'Hello ! Moi, c\'est l\'assistant qui reformule tes textes. Tu veux dire la même chose, mais différemment ? \n        Je suis là pour améliorer la fluidité, la clarté ou le ton de tes phrases.\n    ', 'assistant', '2025-04-11T15:03:18.689Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(111, 'salut, comment ça va ?', 'user', '2025-04-11T15:03:28.532Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(112, 'Bonjour ! En tant qu\'assistant numérique, je n\'ai pas de sentiments, mais je suis ici, prêt à vous aider pour toutes vos questions ou préoccupations juridiques. Comment puis-je vous assister aujourd\'hui ?', 'assistant', '2025-04-11T15:03:37.909Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(113, 'Bonjour, je suis votre assistant juridique spécialisé dans la conversation, comment puis-je vous aider ?', 'assistant', '2025-04-11T16:05:30.376Z', 31, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(114, 'Enchanté ! Je suis ton assistant rédacteur. Que tu aies besoin d\'un texte pro, créatif ou personnel, \n        je peux t\'aider à rédiger avec style et précision. Dis-moi ce que tu veux écrire !\n    ', 'assistant', '2025-04-11T16:06:21.051Z', 31, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(115, 'que contient ce fichier', 'user', '2025-04-11T16:10:51.549Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(116, 'file_1744387851518.txt', 'user', '2025-04-11T16:10:51.550Z', 29, 1, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(117, 'Le fichier que vous avez téléchargé contient plusieurs documents, dont un décret exécutif n° 18-112 du 5 avril 2018. Ce décret fixe le modèle de l\'extrait du registre du commerce délivré sous format électronique, incluant un code électronique appelé \"registre du commerce électronique\" (RCE). Le code RCE est un symbole graphique comportant des données cryptées relatives au commerçant【11:0†source】. Si vous souhaitez obtenir plus de détails sur certains contenus spécifiques, n\'hésitez pas à me le faire savoir.', 'assistant', '2025-04-11T16:11:01.286Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(118, 'donne moi plus de détail', 'user', '2025-04-11T16:11:38.013Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(119, 'Le décret exécutif n° 18-112 du 5 avril 2018 fixe le modèle de l\'extrait du registre du commerce délivré sous format électronique. Voici quelques points clés de ce décret :\n\n1. **Objet du Décret** : Il fixe le modèle de l\'extrait du registre du commerce délivré sous format électronique, introduisant un code électronique appelé \"registre du commerce électronique\" (RCE) sur les extraits du registre du commerce des commerçants, qu\'ils soient des personnes physiques ou morales【15:0†fr_18-112.pdf】.\n\n2. **Code Électronique RCE** : Le RCE est un symbole graphique qui contient des données cryptées concernant le commerçant【15:0†fr_18-112.pdf】.\n\n3. **Caractéristiques du RCE** : Le code est imprimé au recto, en haut à droite de l\'extrait du registre du commerce, en noir, entouré d\'un cadre noir【15:5†fr_18-112.pdf】.\n\n4. **Lecture et Mise à Jour** : Le code peut être lu par des périphériques dotés d\'un dispositif de capture d\'images via une application téléchargeable. La mise à jour des informations du code est assurée par les services du centre national du registre du commerce【15:5†fr_18-112.pdf】.\n\n5. **Validité et Remplacement** : Toute détérioration du code rend l\'extrait du registre du commerce caduc. Les commerçants doivent adapter leur extrait pour inclure ce code RCE dans un délai d\'un an après la publication du décret【15:6†fr_18-112.pdf】.\n\nCes dispositions illustrent l\'initiative pour la modernisation et la sécurisation des informations dans le commerce, facilitant les démarches administratives grâce à des solutions électroniques. Si vous avez d\'autres questions ou besoin de précisions supplémentaires, je suis à votre disposition.', 'assistant', '2025-04-11T16:11:52.237Z', 29, 0, 'reformulation', 'asst_S2SzpBfOfB0NFVx7Q7gLXbin'),
(120, 'Salut ! Je suis ton assistant pour discuter de tout et de rien. \n        Pose-moi une question, raconte-moi ta journée ou parle-moi de ce que tu veux — je suis là pour papoter avec toi !\n    ', 'assistant', '2025-04-11T16:12:32.889Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(121, 'que contient le fichier ?', 'user', '2025-04-11T16:12:46.235Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(122, 'Le fichier téléchargé contient plusieurs documents, chacun traitant de différents sujets législatifs et règlementaires :\n\n1. **Décret exécutif n° 18-112** : Fixe le modèle de l\'extrait du registre du commerce délivré sous format électronique avec un code électronique appelé registre du commerce électronique (RCE), qui est un symbole graphique comportant des données cryptées sur le commerçant【20:0†fr_18-112.pdf】.\n\n2. **FCollectivités-Territoriales** : Ce document traite de la gestion communale, y compris la conservation des actes, la tenue du fichier des électeurs, l\'organisation budgétaire, et d\'autres aspects administratifs et financiers des collectivités territoriales【20:1†FCollectivites-Territoriales.pdf】.\n\n3. **Décret exécutif n° 06-222** : Établit le modèle et le contenu de l\'extrait du registre du commerce, détaillant les informations requises pour les commerçants physiques et moraux inscrits au registre【20:2†fr_06-222.pdf】.\n\nCes documents illustrent divers aspects juridiques relevant de la législation algérienne, y compris les exigences de commerce électronique et les structures administratives. Si vous souhaitez obtenir des informations plus précises ou des détails sur un aspect particulier, faites-le-moi savoir, et je vous assisterai avec plaisir.', 'assistant', '2025-04-11T16:13:17.605Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(123, 'que contient le fichier ?', 'user', '2025-04-11T16:14:01.953Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(124, 'file_1744388041948.txt', 'user', '2025-04-11T16:14:01.953Z', 29, 1, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(125, 'Le fichier contient plusieurs éléments techniques et législatifs. Voici un aperçu de ce qui a été trouvé :\n\n1. **Code** : Des fragments de code pour la gestion et l\'indexation de données via Elasticsearch sont inclus, utilisant des modèles de transformateurs de phrases pour générer des embeddings à partir de textes. Cela inclut l\'utilisation de la librairie `sentence-transformers` et des opérations avec Elasticsearch【24:5†source】.\n\n2. **Modèles de Données** : Les documents contiennent des structures pour les métadonnées éducatives (comme `dc:creator`, `dc:contributor`, etc.), indiquant un traitement de contenu éducatif dans un format normalisé【24:2†source】.\n\n3. **Procédures Légales et Règlementaires** : Les documents incluent également du contenu lié à des décrets exécutifs et lois algériennes, comme le décret exécutif n° 18-112 relatif au registre du commerce électronique. Il spécifie le modèle d\'extraits délivrés et les codes électroniques ajoutés pour sécuriser les informations【24:2†source】.\n\nSi vous avez besoin de précisions sur un aspect particulier, n\'hésitez pas à me le faire savoir.', 'assistant', '2025-04-11T16:14:19.031Z', 29, 0, 'conversation', 'asst_ufQ7CW20LTyC0Wi22jVOigWN'),
(126, 'liste moi les trois lois importantes du droit algérien', 'user', '2025-04-11T16:26:36.798Z', 31, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(127, 'En tant que juriste, je peux vous indiquer trois grands textes de référence du droit algérien :\n\n1) La Constitution de la République algérienne démocratique et populaire :  \n   • C’est la norme suprême à laquelle toutes les autres lois doivent se conformer.  \n   • La première Constitution date de 1963, mais elle a été révisée à plusieurs reprises (notamment en 1976, 1989, 1996, 2016 et 2020) afin de prendre en compte les évolutions politiques et sociales.\n\n2) Le Code civil (Ordonnance n° 75-58 du 26 septembre 1975) :  \n   • Il fixe les règles fondamentales en matière de droit des personnes, de la famille, et des obligations (contrats, responsabilité civile, etc.).  \n   • Il est largement inspiré des traditions juridiques françaises et égyptiennes, tout en tenant compte des spécificités algériennes.\n\n3) Le Code pénal (Ordonnance n° 66-156 du 8 juin 1966) :  \n   • Il définit les infractions (crimes, délits, contraventions) et les peines applicables.  \n   • Il a connu plusieurs modifications afin de s’adapter aux nouveaux enjeux de sécurité et à l’évolution de la société.  \n\nChacun de ces textes joue un rôle essentiel dans l’architecture juridique de l’Algérie et constitue un point de départ incontournable pour comprendre le droit algérien.', 'assistant', '2025-04-11T16:27:20.657Z', 31, 0, 'rédaction', 'asst_04S171lWtvs2Z2q0MSV9nqSP'),
(128, 'Salut ! Je suis ton correcteur attitré. Orthographe, grammaire, ponctuation… rien ne m\'échappe. \n        Envoie-moi ton texte, et je te rends une version impeccable.\n    ', 'assistant', '2025-04-11T16:33:34.671Z', 29, 0, 'vérification', 'asst_rgTUuxYoQxDk6ZjbbKIkJPWM');

-- --------------------------------------------------------

--
-- Structure de la table `threads`
--

DROP TABLE IF EXISTS `threads`;
CREATE TABLE IF NOT EXISTS `threads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `threads`
--

INSERT INTO `threads` (`id`, `id_user`, `name`) VALUES
(29, 1, 'juridique'),
(31, 1, 'cas 1');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `psw` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `fullname`, `email`, `psw`) VALUES
(1, 'cherif', 'cherif@gmail.com', 'test123');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
