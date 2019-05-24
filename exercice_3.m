clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 6.0e+03;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = randi(37);
posture = randi(6);
chemin = './Images_Projet_2019';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 
% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C = X_c*W;
donnees_apprentissage = C(:,1:N);

% N premieres composantes principales de l'image de test :
image_test_centre = image_test-individu_moyen;
donnees_test = image_test_centre * W;
donnees_test = donnees_test(:,1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
K = 1;
listeClass = 1:37; %37 individus
listeLabel = 1:37; %individus identifiés par leur numéros
labelA = [2 2 2 2 4 4 4 4 6 6 6 6 37 37 37 37 ];
[individu_reconnu,distances] = kppv(donnees_apprentissage, donnees_test, N ,K, listeClass, listeLabel, labelA)

% Affichage du resultat :
if ( distances(1)<s )
	%individu_reconnu = nearest_neighbors_projection(1,:)*W(:,1:N)'+individu_moyen;
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end
