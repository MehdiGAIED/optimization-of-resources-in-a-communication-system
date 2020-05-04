/*********************************************
 * OPL 12.9.0.0 Model
 
 * Author: Client
 * Creation Date: 4 mai 2020 at 02:08:49
 *********************************************/
 
 //Les nouveaux  structures 
 
 
 tuple point {//structure définissant un point dans un système de coordonnée cartésien
  float x;//abscisse 
  float y;//ordonnée
  float z;// hauteur 
 }
 
  tuple acesspt{ // structure définissant un point d'accés
  
  key string name;//nom d'un AP
  point position;// position d'un AP dans l'espace
  float d; //sa distance euclidienne
  float M;// facteur de pulse modulation
  float debit; //le débit 
  }
 
 
//les variables 
float ro=1;// un facteur physique lié au aps lifi
float B=20;// la bande lifi
{acesspt} APlifi={<"APL1",<1,0,0>, 1,8,20*B*lg(8/(1+ro))>, <"APL2",<2,0,0> ,2,6,20*B*lg(6/(1+ro))>};//les aps lifi
{acesspt} APwifi={<"APw",<3,0,0>,3,4,120>}; //les ap wifi
{acesspt} AP=APlifi union APwifi ;//les ap total
{string} users={"U1","U2","U3","U4","U5"};// les utilisateurs
float Pdl=0.8;// proportion de wifi en downlink
int T=20; // TDMA********T selon l'article est égal k(=10 dans l'article') fois le nombre de users donc T=20 
range temps=1..T;  //intervalle d'entier associé au temps d'association




//déclarer les variables de décisions

dvar boolean y[AP][users][temps];// la sortie de l'algorithme est une matrice binaire à 3 dimensions 
//qui donne les associations entre AP et utilisateur qui auront lieu

//model 

 
 

         maximize 
               sum(user in users) (sum(ap in AP) (sum(t in temps ) y[ap][user][t]*log(ap.debit*(t/T))));
                                                               
                                               
  //les contraintes à satisfaire 
 subject to {
  
 //un utilisateur ne peut pas etre associé à plus q'un AP
  forall(user in users)
          ( sum(a in AP) sum(t in temps) y[a][user][t])==1;
          
          
//le temps d'allocation d'un AP lifi ne peut pas dépasser l'intervalle de TDMA T ***cette contrainte doit etre valable pour tous les APs lifi
 forall(a in APlifi)
 
     (sum(user in users) sum(t in temps) y[a][user][t]*(t/T))<=1;
     
     
 
// le temps l'allocation d'un APwifi ne peut pas  dépasser l'intervalle de TDMA T *****cette contrainte doit etre valable pour tous les APswifi
forall( a in APwifi)
  (sum(user in users) sum(t in temps) y[a][user][t]*(t/T))<=Pdl;
   
    }
 