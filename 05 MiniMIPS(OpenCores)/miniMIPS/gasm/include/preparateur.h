/**********************************************************************************/
/*                                                                                */
/*    Copyright (c) 2003, Hangouet Samuel, Mouton Louis-Marie all rights reserved */
/*                                                                                */
/*    This file is part of gasm.                                                  */
/*                                                                                */
/*    gasm is free software; you can redistribute it and/or modify                */
/*    it under the terms of the GNU General Public License as published by        */
/*    the Free Software Foundation; either version 2 of the License, or           */
/*    (at your option) any later version.                                         */
/*                                                                                */
/*    gasm is distributed in the hope that it will be useful,                     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of              */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               */
/*    GNU General Public License for more details.                                */
/*                                                                                */
/*    You should have received a copy of the GNU General Public License           */
/*    along with gasm; if not, write to the Free Software                         */
/*    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   */
/*                                                                                */
/**********************************************************************************/


/* If you encountered any problem, please contact :                               */
/*                                                                                */
/*   lmouton@enserg.fr                                                            */
/*   shangoue@enserg.fr                                                           */
/*                                                                                */


/*********************************************************************************************/
/* MODULE PREPARATEUR                                                                        */
/* ce module a pour but de lire le fichier Syntaxe du programme et de générer l'arbre des    */
/* lexèmes qui lui correspond.                                                               */
/*                                                                                           */
/* Le seul point d'accès de ce module est la fonction init_arbre qui reçoit le nom du        */
/* fichier Syntaxe à utiliser.                                                               */
/*                                                                                           */
/*********************************************************************************************/

#ifndef M_PREPA_FLAG
#define M_PREPA_FLAG

#include <formateur.h>
#include <parametres.h>
#include <adaptateur.h>

/*********************************************************************************************/
/*                              DEFINITION DE L'ARBRE DE LEXEMES                             */
/* Définition de l'arbre de lexèmes généré par le préparateur et des autres types auquels il */
/* se rapporte.                                                                              */
/*********************************************************************************************/

/* Définition de la feuille de l'arbre.                                                      */
typedef struct
{
        type_mask * mask_primaire;      /* masque primaire du codage.                        */
        char nbr_func;                  /* nombre de fonctions.                              */
        type_ptr_fgm * ptr_func;        /* adresse du début du tableau des fonctions.        */
} type_feuille;

/* Définition de la structure arbre elle-même.                                               */
typedef struct noeud_arbre
{
        type_lexeme lexeme;
        struct noeud_arbre * ptr_fils;
        struct noeud_arbre * ptr_frere;
        type_feuille * ptr_feuille;
} type_noeud;

#define ALLOC_FEUILLE(feuille)  \
{\
        feuille=(type_feuille *) malloc(sizeof(type_feuille));\
        if (feuille==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);\
        feuille->mask_primaire=NULL;\
        feuille->nbr_func=0;\
        feuille->ptr_func=NULL;\
}

#define FREE_FEUILLE(feuille)   \
{\
        if (feuille->mask_primaire!=NULL) FREE_MASK(feuille->mask_primaire);\
        if (feuille->ptr_func!=NULL) free(feuille->ptr_func);\
        free(feuille);\
}       

#define ALLOC_NOEUD(noeud)      \
{\
        noeud=(type_noeud *) malloc(sizeof(type_noeud));\
        if (noeud==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);\
        noeud->lexeme.type=0;\
        noeud->lexeme.valeur.op=0;\
        noeud->ptr_fils=NULL;\
        noeud->ptr_frere=NULL;\
        noeud->ptr_feuille=NULL;\
}

#define FREE_NOEUD(noeud)       \
{\
        if (noeud->ptr_feuille!=NULL) FREE_FEUILLE(noeud->ptr_feuille);\
        free(noeud);\
}


/* Exportation de la racine de l'arbre des lexèmes.                                          */
extern type_noeud * root;


/* Nombre maximal de fonctions pour une instruction dans le fichier Syntaxe.                 */
#define MAX_FONCTIONS           16

int init_arbre(char * fichier_syntaxe);
void clear_preparateur();

#endif
