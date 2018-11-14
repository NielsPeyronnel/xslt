# TP Le masque et la Plume (XSLT)
Réaliser et appliquer une transformation sur le fichier XML du Masque et la Plume pour en obtenir une page web :

> Partir du fichier XML fourni en solution dans la section 2 - Définitions DTD en le modifiant pour faire référence à un fichier de transformation XSLT ( *.xsl* )


Construire le fichier XLST de manière à ce qu'il permette d'obtenir une page web au format HTML5 comportant :

> Prendre modèle sur [ce site](http://edutechwiki.unige.ch/fr/Tutoriel_XSLT_débutant#Output_en_HTML5) pour cela.

* une référence à un fichier de style CSS externe chargé de sa mise en forme
un petit texte introductif de votre cru.

* l'ensemble des deux émissions du Masque et la Plume, avec pour chacune d'elles, sa date, son type, titre, sous-titre, l'animateur, les critiques présents et leur organe de presse, et selon le type de l'émission, pour chaque :

> Tirer au mieux parti des éléments communs aux livres et aux films, pour factoriser leur transformation 

  * Livre :

    son titre, éventuel sous-titre, suivi de l'"identité" de son auteur, son éditeur (portant un lien vers son site Web), sa date de parution, son nombre de pages, ISBN et prix éditeur
son résumé
la liste éventuelle de ses personnages principaux.
  * Film :
   
     son titre, éventuel sous-titre, suivi des "identités" de ses réalisateurs et scénaristes, son année de production, ses nationalités, sa durée, sa date de sortie
son synopsis
son "casting", entendu par la liste de ses acteurs/actrices, avec pour chacun :
son "identité"
le nom du personnage (supposé unique) qu'il a incarné dans le film.
  * L'**identité** d'un artiste est composée comme suit : texte "prénom nom", dont le survol affiche son sexe et le pays de sa nationalité et porte éventuellement un lien, s'il possède une biographie, dont le clic amène vers sa description en annexe.
  * en annexe, la liste des artistes comportant une biographie triée par leur nom, avec leur prénom et nom, sexe, pays de nationalité, et biographie en question.


