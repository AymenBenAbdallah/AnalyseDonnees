%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [individu_reconnu, distances] = kppv(DataA,DataT,N,K,ListeClass,listeLabel,labelA)

[Na ,~]= size(DataA);
[Nt,~] = size(DataT);

% Initialisation du vecteur d'étiquetage des images tests
%Partition = zeros(Nt_test,1);
%matrice_confusion = zeros(Nt_test);
disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt
    
    disp(['image test n°' num2str(i)])
    
    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    distances = sum((DataA - repmat(DataT(i,:),Na(1),1) ).^2,2);
    %sqrt non obligatoire
    
    % On ne garde que les indices des K + proches voisins
    [tri, I] = sort(distances);
    I = I(1:K);
    tri(I);
    % Comptage du nombre de voisins appartenant à chaque classe
    
    listeLabel = labelA(I);
    
    nbrClass = zeros (size(ListeClass));
    for j = 1:length(ListeClass)
        nbrClass(1,j) = sum(listeLabel == ListeClass(j));
    end
    % Recherche de la classe contenant le maximum de voisins
    [occurenceMax indiceClassMax] = max(nbrClass);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    if length(indiceClassMax) == 1
        individu_reconnu = ListeClass(indiceClassMax);
        
    else 
        etiquette = 0;
    end
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    
    %Partition(i) = etiquette;
    %[label indiceClasse] = find(labelT(i) == ListeClass);
    %[trouve indiceTrouve] = find(ListeClass == etiquette);
    %matrice_confusion(indiceClasse , indiceTrouve) = matrice_confusion(indiceClasse , indiceTrouve) + 1 ;
    
    
    %err = Nt_test- sum(diag(matrice_confusion))
end

