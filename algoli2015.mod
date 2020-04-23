/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Client
 * Creation Date: 19 avr. 2020 at 19:43:55
 *********************************************/
//lire dans un fichier

int nuser=...;// nombre d'utilisateur
int nAPLIFI=...;// nombre d'AP lifi
int nAPwifi=...;//nombre d'AP wifi
int Pdl=...;
int T=...;// temps d'association entre un AP et un utilisateur
int alpha ;
int u;
float debit=...;
range temps=1..T;  //intervalle d'entier associ� au temps d'association
range user=1..nuser; //intervalle d'entier associ� au nombre d'utilisateur
range APLIFI=1..nAPLIFI;//intervalle d'entier associ� au nombre d'ap lifi
range APwifi=1..nAPwifi;//intervalle d'entier associ� au nombre d'ap wifi
range APtot=1..nAPwifi+nAPLIFI;//intervalle d'entier associ� au nombre d'ap total
int C[APLIFI]; //les AP lifi
int W[APwifi];// les AP wifi
int CUW[APtot]=C[APLIFI]+W[APwifi];//les APs totals


//d�clarer les variables de d�cisions

dvar boolean y[APtot][user];

//model 

maximize
 
  sum(u in user) (sum(alpha in APtot) (sum(t in temps ) y[alpha][u]*log(debit*(t/T))));
  
  
  
  
  subject to{
 ( sum(alpha in APtot) sum(t in temps) y[alpha][u] )=1;
 for (alpha in C)
 {
  (sum(u in user) sum(t in temps) y[alpha][u]*(t/T))<=1;
}  

  (sum(u in user) sum(t in temps) y[alpha][u]*(t/T))<=1;
   
    
  }
