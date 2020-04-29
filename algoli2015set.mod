/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Client
 * Creation Date: 27 avr. 2020 at 11:34:23
 *********************************************/
//les variables 

{string} APlifi={"APL1","APL2"};//les aps lifi
{string} APwifi={"APw"}; //les ap wifi
{string} AP=APlifi union APwifi ;//les ap total
{string} users={"U1","U2"};// les utilisateurs
float Pdl=0.8;// proportion de wifi en downlink
int T=20; // TDMA********T selon l'article est �gal k(=10 dans l'article') fois le nombre de users donc T=20 
float M=3;// le facteur de modulation
float ro=1;// un facteur physique li� au aps lifi
float B=20*pow(10,6);// la bande lifi
float debit=20*B*lg(M/(1+ro));// le d�bit
range temps=1..T;  //intervalle d'entier associ� au temps d'association



//d�clarer les variables de d�cisions

dvar boolean y[AP][users][temps];// la sortie de l'algorithme est une matrice binaire � 3 dimensions 
//qui donne les associations entre AP et utilisateur qui auront lieu

//model 

maximize 
    
         sum(user in users) (sum(ap in AP) (sum(t in temps ) y[ap][user][t]*log(debit*(t/T))));
                                                               
                                                 
  //les contraintes � satisfaire 
 subject to {
  
 //un utilisateur ne peut pas etre associ� � plus q'un AP
  forall(user in users)
          ( sum(a in AP) sum(t in temps) y[a][user][t])==1;
          
          
//le temps d'allocation d'un AP lifi ne peut pas d�passer l'intervalle de TDMA T ***cette contrainte doit etre valable pour tous les APs lifi
 forall(a in APlifi)
 
     (sum(user in users) sum(t in temps) y[a][user][t]*(t/T))<=1;
     
     
 
// le temps l'allocation d'un APwifi ne peut pas  d�passer l'intervalle de TDMA T *****cette contrainte doit etre valable pour tous les APswifi
forall( a in APwifi)
  (sum(user in users) sum(t in temps) y[a][user][t]*(t/T))<=Pdl;
   
    }
 