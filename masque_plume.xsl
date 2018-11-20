<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes" method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Le Masque et la Plume</title>
				<meta charset="utf-8"/>
				<meta content="width=device-width, initial-scale=1" name="viewport"/>
				<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"/>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"/>
				<link href="masque_plume.css" rel="stylesheet" type="text/css"/>
				<link href="hover-min.css" rel="stylesheet"/>
			</head>

			<!-- Cette partie permet de lancer le JS tel que le tooltip bootstrap et le bouton qui permet de revenir en haut du site -->

			<script>
				$(document).ready(function(){
    				$('[data-toggle=&quot;tooltip&quot;]').tooltip(); 
				});

				$(document).ready(function(){
     				$(window).scroll(function () {
			            if ($(this).scrollTop() &gt;50) {
			                $('#back-to-top').fadeIn();
			            } else {
			                $('#back-to-top').fadeOut();
			            }
        			});

			        $('#back-to-top').click(function () {
			            $('#back-to-top').tooltip('hide');
			            $('body,html').animate({
			                scrollTop: 0
			            }, 800);
			            return false;
			        });
	        
	        		$('#back-to-top').tooltip('show');

				});
			</script>
			<body>
				<!-- Grand header qui présente le TP -->
				<div class="jumbotron text-center">
					<h1>Le Masque et la Plume</h1>
					<p>Ce site a été réalisé par
						<strong>Niels Peyronnel</strong>
						dans le cadre du TP d'XML encadré par
						<strong>Martial Bret.</strong></p>
						<p>Le code source est disponible <strong><a class="linkgit" href="https://github.com/NielsPeyronnel/xslt">ici</a>.</strong></p>
				</div>
				<hr/>

				<!-- On fait un traitement pour chaque émission à l'aide du for-each -->

				<xsl:for-each select="masque_plume/emissions/emission">
					<div class="btn btn-block hvr-sink" data-target="#{generate-id(.)}" data-toggle="collapse" type="button">
						<div class="jumbotron text-center sep ">
							<h2>
								<xsl:value-of select="titre"/>
							</h2>
							<h3>
								<xsl:value-of select="concat('Présenté par ',id(@animateur))"/>
							</h3>
							<p>
								<xsl:value-of select="concat('Émission du ',@date)"/>
							</p>
						</div>
					</div>
					<div class="collapse" id="{generate-id(.)}">
						<div class="container-table text-center ">
							<div class="row vertical-center-row">
								<div class="text-center col-md-6 col-md-offset-3">
									<div class="container-fluid bg-greyer rad">
										<p>
											<strong>Critiques :
									</strong>
											<br/>
											<xsl:for-each select="id(@critiques)">
												<xsl:variable name="id_org" select="@organe_de_presse"/>
												<xsl:value-of select="concat(.,' (',/masque_plume/organes_de_presse/organe_de_presse[@id=$id_org]/nom,') ')"/>
												<br/>
											</xsl:for-each>
										</p>
									</div>
									<h4>
										<xsl:value-of select="sous-titre"/>
									</h4>
								</div>
							</div>
						</div>

						<!-- On teste si l'émission contient des livres ou des films, l'avantage de cette solution est que nous pouvons avoir les deux au seins d'une même émission sans changer le code -->

						<xsl:choose>
							<xsl:when test="films">
								<div class="container-fluid text-center">
									<h3>FILMS
										
										<span class="glyphicon glyphicon-film logo"/></h3>
								</div>
								<xsl:for-each select="films/film">
									<div class="container">
										<div class="container-fluid bg-grey text-center text-center radtop">
											<h3>
												<xsl:value-of select="titre"/>
												<xsl:if test="sous-titre">
													<i>
														<xsl:value-of select="concat(' : ',sous-titre)"/>
													</i>
												</xsl:if>
											</h3>
										</div>
										<div class="container-fluid mycontent-top">
											<div class="row bg-greyer text-center radbottom">
												<div class="col-sm-4">
													<strong>Année : </strong>
													<xsl:value-of select="@annee_production"/>
												</div>
												<div class="col-sm-4">
													<strong>Réalisateur : </strong>
													<xsl:variable name="id_real" select="casting/@realisateurs"/>
													<a href="#{$id_real}">
														<xsl:value-of select="concat(/masque_plume/artistes/artiste[@id=$id_real]/prenom,' ',/masque_plume/artistes/artiste[@id=$id_real]/nom)"/>
													</a>
												</div>
												<div class="col-sm-4">
													<strong>Scénariste : </strong>
													<xsl:for-each select="id(casting/@scenaristes)">
														<xsl:variable name="scenar" select="concat(./prenom,' ',./nom)"/>
														<a href="#{./@id}">
															<xsl:value-of select="concat($scenar,'  ')"/>
														</a>
													</xsl:for-each>
												</div>
												<div class="col-sm-4">
													<strong>Nationalité(s) : </strong>
													<xsl:for-each select="id(@pays)">
														<xsl:value-of select="concat(.,' ')"/>
													</xsl:for-each>
												</div>
												<div class="col-sm-4">
													<strong>Durée : </strong>
													<xsl:value-of select="substring-after(substring-before(@duree,'M'),'PT')"/>
												</div>
												<div class="col-sm-4">
													<strong>Date de sortie : </strong>
													<xsl:value-of select="@date_sortie"/>
												</div>
											</div>
										</div>
										<br/>
										<div class="jumbotron text-center">
											<h4>Synopsis</h4>
											<hr class="divider"/>
											<p>
												<xsl:value-of select="synopsis"/>
											</p>
										</div>
										<xsl:if test="personnages/personnage">
											<div class="btn btn-block hvr-sink" data-target="#{generate-id(titre)}" data-toggle="collapse" type="button">
												<div class="jumbotron text-center">
													<h4>Casting</h4>
													<div class="collapse" id="{generate-id(titre)}">
														<xsl:for-each select="personnages/personnage">
															<xsl:variable name="id_act" select="@incarne_par"/>
															<xsl:choose>
																<xsl:when test="contains(/masque_plume/artistes/artiste[@id=$id_act]/@sexe,'M')">
																	<xsl:variable name="sex_nat" select="concat('Homme',', ',id(/masque_plume/artistes/artiste[@id=$id_act]/@pays))"/>
																	<p data-toggle="tooltip" title="{$sex_nat}">
																		<strong>
																			<xsl:variable name="acteur" select="concat(/masque_plume/artistes/artiste[@id=$id_act]/prenom,' ',/masque_plume/artistes/artiste[@id=$id_act]/nom)"/>
																			<xsl:value-of select="concat($acteur,' : ')"/>
																		</strong>
																		<xsl:value-of select="."/>
																	</p>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:variable name="sex_nat" select="concat('Femme',', ',id(/masque_plume/artistes/artiste[@id=$id_act]/@pays))"/>
																	<p data-toggle="tooltip" title="{$sex_nat}">
																		<strong>
																			<xsl:variable name="acteur" select="concat(/masque_plume/artistes/artiste[@id=$id_act]/prenom,' ',/masque_plume/artistes/artiste[@id=$id_act]/nom)"/>
																			<xsl:value-of select="concat($acteur,' : ')"/>
																		</strong>
																		<xsl:value-of select="."/>
																	</p>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</div>
												</div>
											</div>
										</xsl:if>
									</div>
									<hr/>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="livres">
								<div class="container-fluid text-center">
									<h3>LIVRES	
										<span class="glyphicon glyphicon-book logo"/></h3>
								</div>
								<xsl:for-each select="livres/livre">
									<div class="container">
										<div class="container-fluid bg-grey text-center radtop">
											<h3>
												<xsl:value-of select="titre"/>
												<xsl:if test="sous-titre">
													<i>
														<xsl:value-of select="concat(' : ',sous-titre)"/>
													</i>
												</xsl:if>
											</h3>
										</div>
										<div class="container-fluid mycontent-top">
											<div class="row bg-greyer text-center radbottom">
												<div class="col-sm-4">
													<strong>Date de parution : </strong>
													<xsl:value-of select="@date_parution"/>
												</div>
												<div class="col-sm-4 mycontent-left">
													<strong>Auteur : </strong>
													<xsl:variable name="id_aut" select="@auteur"/>
													<xsl:variable name="aut" select="concat(/masque_plume/artistes/artiste[@id=$id_aut]/prenom,' ',/masque_plume/artistes/artiste[@id=$id_aut]/nom)"/>
													<a href="#{$id_aut}">
														<xsl:value-of select="$aut"/>
													</a>
												</div>
												<div class="col-sm-4 mycontent-left">
													<strong>Éditeur : </strong>
													<xsl:variable name="id_edit" select="@editeur"/>
													<a href="{/masque_plume/editeurs/editeur[@id=$id_edit]/@site_web}">
														<xsl:value-of select="/masque_plume/editeurs/editeur[@id=$id_edit]/nom"/>
													</a>
												</div>
												<div class="col-sm-4 mycontent-left">
													<strong>ISBN : </strong>
													<xsl:value-of select="@isbn"/>
												</div>
												<div class="col-sm-4 mycontent-left">
													<strong>Nombre de pages : </strong>
													<xsl:value-of select="@nb_pages"/>
												</div>
												<div class="col-sm-4 mycontent-left">
													<strong>Prix : </strong>
													<xsl:value-of select="concat(@prix,'€')"/>
												</div>
											</div>
										</div>
										<br/>
										<div class="jumbotron text-center">
											<h3>Résumé</h3>
											<hr class="divider"/>
											<p>
												<xsl:value-of select="resume"/>
											</p>
										</div>
										<xsl:if test="personnages/personnage">
											<div class="btn btn-block hvr-sink" data-target="#{generate-id(titre)}" data-toggle="collapse" type="button">
												<div class="jumbotron text-center">
													<h4>Personnages</h4>
													<div class="collapse" id="{generate-id(titre)}">
														<xsl:for-each select="personnages/personnage">
															<p>
																<xsl:value-of select="."/>
															</p>
														</xsl:for-each>
													</div>
												</div>
											</div>
										</xsl:if>
									</div>
									<hr/>
								</xsl:for-each>
							</xsl:when>
						</xsl:choose>
						<hr/>
					</div>
				</xsl:for-each>

				<!-- On traite ici toute la partie annexe, en concernant seulement les artistes qui possèdent une autobiographie et ces derniers sont triés par leur nom de famille -->

				<div class="container">
					<div class="jumbotron text-center sep annexe">
						<h2>Annexe
							</h2>
						<p>Biographie des artistes
							</p>
					</div>
				</div>
				<xsl:for-each select="/masque_plume/artistes/artiste">
					<xsl:sort select="nom"/>
					<xsl:if test="biographie">
						<div class="container" id="{@id}">
							<div class="container-fluid bg-grey text-center radtop">
								<h3>
									<xsl:value-of select="concat(prenom,' ',nom)"/>
								</h3>
							</div>
							<div class="container-fluid mycontent-top">
								<div class="row bg-greyer text-center radbottom">
									<div class="col-sm-6">
										<strong>Sexe : </strong>
										<xsl:choose>
											<xsl:when test="contains(@sexe,'M')">Homme
									</xsl:when>
											<xsl:otherwise>Femme
									</xsl:otherwise>
										</xsl:choose>
									</div>
									<div class="col-sm-6">
										<strong>Nationalité : </strong>
										<xsl:for-each select="id(@pays)">
											<xsl:value-of select="concat(.,' ')"/>
										</xsl:for-each>
									</div>
								</div>
							</div>
							<br/>
							<div class="jumbotron text-center annexe">
								<h4>Biographie</h4>
								<hr class="divider"/>
								<p>
									<xsl:value-of select="biographie"/>
								</p>
							</div>
						</div>
						<hr/>
					</xsl:if>
				</xsl:for-each>
				<a class="btn btn-default btn-lg back-to-top" data-placement="left" data-toggle="tooltip" href="#" id="back-to-top" role="button" title="Retour">
					<span class="glyphicon glyphicon-chevron-up"/>
				</a>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>