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


#ifndef M_PARAMETRES_FLAG
#define M_PARAMETRES_FLAG

#include <formateur.h>

/*********************************************************************************************/
/* MODULE CONTENANT LES VARIABLES D'ENVIRONNEMENT                                            */
/*********************************************************************************************/

/* Déclaration de variables globales concernant la syntaxe de l'assembleur                   */

/* Sous-typage des lexèmes ALPHA :                                                           */
typedef struct
{
        type_type_lex code;
        char * chaine;
} type_paire;

extern type_paire * regle_typage;

#define MAX_SOUS_TYPES 15 /* Nombre maximum de sous types codables.                          */

/* Sensibilité à la casse (oui par défaut)                                                   */
extern int casse_sens;

/* Nom du fichier de macro à inclure par défaut en début de code                             */
extern char * fich_macro_def;

/* Chaines de caractères pour les directives préprocesseur.                                  */
extern char * include_str;
extern char * define_str;
extern char * undef_str;

/* Variables pour la définition des sous-types.                                              */
extern int nbr_sous_types;

/* Lexème séparateur d'instructions.                                                         */
extern type_lexeme * seplex;

/* Variables globales utilisées par le programme.                                            */

/* Exportation du pseudo compteur ordinal.                                                   */
extern int pco;

/* Activation de la lsite d'assemblage.                                                      */
extern int active_list;

#endif
