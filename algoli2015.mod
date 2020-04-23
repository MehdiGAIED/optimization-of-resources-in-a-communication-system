/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Client
 * Creation Date: 19 avr. 2020 at 19:43:55
 *********************************************/
//les variables 

int nuser=2;// nombre d'utilisateur
int nAPLIFI=4;// nombre d'AP lifi
int nAPwifi=1;//nombre d'AP wifi
float Pdl=0.8;
int T=500;// temps d'association entre un AP et un utilisateur(k*10)

int alpha ;
int u;
float M=2;// une généralisation de M en fonction de la distance est demandé 
float ro=1;
float B=20*pow(10,6);
float debit=20*B*lg(M/(1+ro));
range temps=1..T;  //intervalle d'entier associé au temps d'association
range user=1..nuser; //intervalle d'entier associé au nombre d'utilisateur
range APLIFI=1..nAPLIFI;//intervalle d'entier associé au nombre d'ap lifi
range APwifi=1..nAPwifi;//intervalle d'entier associé au nombre d'ap wifi
range APtot=1..nAPwifi+nAPLIFI;//intervalle d'entier associé au nombre d'ap total
int C[APLIFI]=[1,2,3,4]; //les AP lifi
int W[APwifi]=[0];// les AP wifi
int CUW[APtot]=[0,1,2,3,4]; //]append(all(i in APwifi) W[i],all(i in APLIFI) C[i]);//les APs totals
int  U[user]=[1,2];// les utilisateurs

//déclarer les variables de décisions

dvar boolean y[APtot][user];// la sortie de l'algorithme est une matrice binaire 
//qui donne les associations entre AP et utilisateur qui auront lieu

//model 

maximize 
    
         sum(u in user) (sum(alpha in APtot) (sum(t in temps ) y[CUW[alpha]][U[u]]*log(debit*(t/T))));
                                                                // pb de modélisation de la variable aléatoire y
                                                                   //l'algorithme ne  converge pas '
  
 subject to{
  
 
   //forall (us in U)// cette contrainte doit etre valable pour tous les utilisateurs
          ( sum(alpha in APtot) sum(t in temps) y[CUW[alpha]][U[u]])<=1;
 //forall (alpha in C)// cette contrainte doit etre valable pour tous les APs lifi
 {
  (sum(u in user) sum(t in temps) y[alpha][u]*(t/T))<=1;
}  
//forall (alpha in W)// cette contrainte doit etre valable pour tous les APs wifi
  (sum(u in user) sum(t in temps) y[alpha][u]*(t/T))<=1;
   
    
  }
