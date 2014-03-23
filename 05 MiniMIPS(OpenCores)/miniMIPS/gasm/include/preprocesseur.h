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


#ifndef M_PREPROCESSEUR_FLAG
#define M_PREPROCESSEUR_FLAG

#include <stdio.h>
#include <parametres.h>

/********************************************************************************************
 *                                POINTS D'ENTREE                                           *
 ********************************************************************************************/
void            push_lexeme(type_lexeme * ptr_recrach);
type_lexeme *   pop_lexeme();

/* ATTENTION !!! les lexemes rendu avec push_lexeme ne seront pas à nouveau traités lors de *
 * l'appel au prochain pop_lexeme. Ainsi, les macro ajoutées ne s'appliquent qu'à partir    *
 * du prochain lexème lu pour la première fois, c'est-à-dire quand la pile est vide. De     *
 * meme, la ligne et la chaine d'origine fournie coincident avec le dernier lexème non issu *
 * de la pile. Les push et pop ne constituent qu'un outil surpeficiel à manier avec soin.   */

int     init_preprocesseur(char * main_asm);
void    clear_preprocesseur();
void    suppress_macro(char * nom_macro);
void    ajoute_macro(char * nom_macro, FILE * flux_def);
void    liste_table_macro(FILE *);

/********************************************************************************************
 *            GENERATION DE L'ORIGINE DES LEXEMES POUR LA LOCALISATION D'ERREUR             *
 *                                                                                          *
 * Attention, ne pas oublier de faire free() sur le pointeur renvoyé !                      *
 ********************************************************************************************/
int ligne_courante();
char * gen_orig_msg();

#endif
