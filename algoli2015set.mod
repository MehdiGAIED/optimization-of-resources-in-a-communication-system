/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Client
 * Creation Date: 27 avr. 2020 at 11:34:23
 *********************************************/
//les variables 


 {string} APlifi={"APL1","APL2"};
{string} APwifi={"APw"};
{string} AP={"APL1","APL2","APw"};
{string} users={"U1","U2"};
float Pdl=0.8;
int T=20;
//string user;
//string ap;
float M=3;// une généralisation de M en fonction de la distance est demandé 
float ro=1;
float B=20*pow(10,6);
float debit=20*B*lg(M/(1+ro));
range temps=1..T;  //intervalle d'entier associé au temps d'association



//déclarer les variables de décisions

dvar boolean y[AP][users];// la sortie de l'algorithme est une matrice binaire 
//qui donne les associations entre AP et utilisateur qui auront lieu

//model 

maximize 
    
         sum(user in users) (sum(ap in AP) (sum(t in temps ) y[ap][user]*log(debit*(t/T))));
                                                               
                                                 
  
 subject to{
  
 
  forall(user in users)
          ( sum(a in AP) sum(t in temps) y[a][user])==1;
 // cette contrainte doit etre valable pour tous les APs lifi
 forall(a in APlifi)
 
     (sum(user in users) sum(t in temps) y[a][user]*(t/T))<=1;
 
// cette contrainte doit etre valable pour tous les APs wifi
forall( a in APwifi)
  (sum(user in users) sum(t in temps) y[a][user]*(t/T))<=Pdl;
   
   
    
  }
 