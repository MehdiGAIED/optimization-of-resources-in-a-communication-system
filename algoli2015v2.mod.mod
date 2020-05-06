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
 
  tuple accesspt{ // structure définissant un point d'accés
  
  int ida;//  identifiant nom d'un AP
  point position;// position d'un AP dans l'espace
  int type;// type de point d'accés  
  
  }
  
  tuple user{//station
  int idu;// identifiant de l'utilisateur'
 point position ;
 int association;// association
 int utilisation;// t
 float debit_atteint;//debit_phy.t/T
 
 } 
 
//les variables 

int n=10;
range I=1..n;
float ro=1;// un facteur physique lié au aps lifi
float B=20;// la bande lifi
float Pdl=0.8;// proportion de wifi en downlink
int T=5*n; // TDMA********T selon l'article est égal k(=10 dans l'article') fois le nombre de users donc T=20 
range temps=1..T;  //intervalle d'entier associé au temps d'association
float debit_phy[1..n];// le débit physique
int debit;
{accesspt} APlifih={<i,<3.75*i,0,0>,1> | i in 1..4 };//les aps lifi horizental
{accesspt} APlifiv={<j+4,<0,3.75*j,0>, 1> | j in 1..4 };//les aps lifi vertical
{accesspt} APlifi=APlifih union  APlifiv;//les ap lifi total en grille 4*4 sur un espace 15*15*3
{accesspt} APwifi={<0,<7.5,7.5,1.5>,2>}; //les ap wifi
{accesspt} AP=APlifi union APwifi; //les aps totals
{user} users={<i,<rand(15),rand(15),rand(3)>,0,0,0>|i in 1..n};// les utilisateurs
float D[i in  0..n-1][j in 0 ..15]=sqrt(pow(item(users,i).position.x-item(AP,j).position.x,2)+pow(item(users,i).position.y-item(AP,j).position.y,2)+pow(item(users,i).position.z-item(AP,j).position.z,2));
float d[i in 0..n-1]=min(D[i]);


/**********************************pre-traitement******************************/
execute pre_model{

     
     for (var i = 1; i <= n; i++)
      {
      if( d[i] <=1)      
        debit=800;
      if( 1<d[i]<=2)
         debit=600;
      if (2<d[i]<=4)
          debit=400;
          
      else
         debit=0;
         
      debit_phy[i]=debit;   
       
     }
}
  
/************************************************************************************/
//déclarer les variables de décisions

dvar boolean y[AP][users][temps];// la sortie de l'algorithme est une matrice binaire à 3 dimensions 
//qui donne les associations entre AP et utilisateur qui auront lieu

//model 

 
 

         maximize 
               sum(i in 0..n-1) (sum(j in 0..15) (sum(t in temps ) y[item(AP,i)][item(users,j)][t]*log(debit_phy[i]*(t/T))));//debit_atteint=debit_phy.t/T
                                                               
                                               
  //les contraintes à satisfaire 
 subject to {
 
 //un utilisateur ne peut pas etre associé à plus q'un AP
  forall(i in 0..n)
          ( sum(j in 1..16) sum(t in temps) y[item(AP,i)][item(users,j)][t])==1;
          
          
//le temps d'allocation d'un AP lifi ne peut pas dépasser l'intervalle de TDMA T ***cette contrainte doit etre valable pour tous les APs lifi
 forall(k in 0..14)
 
     (sum(i in 0..n-1) sum(t in temps)y[item(AP,k)][item(users,i)][t]*(t/T))<=1;
     
     
 
// le temps l'allocation d'un APwifi ne peut pas  dépasser l'intervalle de TDMA T *****cette contrainte doit etre valable pour tous les APswifi
forall(l in 0..0)
  (sum(i in 0..n-1) sum(t in temps) y[item(AP,i)][item(users,i)][t]*(t/T))<=Pdl;
   
    }
    
 /**************************************************post_model**********************************************************************************/
execute post_model{

for (var i=0; i<=n;i++){
  
  for(var j=0; j<=15 ;j++){
      
      for (var t=1;t<=20;t++){
          if (y[item(AP,i)][item(users,j)][t]==1)
          {
             item(users,j).association=1;
             item(users,j).utilisation=t;
             item(users,j).debit_atteint=debit_phy*(t/T);
             
          }          
                      }}
}

}
/**************************************************************************************************************************************************/
 
    
    
    
    
    
 