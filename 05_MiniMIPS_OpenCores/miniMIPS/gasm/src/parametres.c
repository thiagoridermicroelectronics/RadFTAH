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

#include "parametres.h"

#include <stdio.h>

#include <debogueur.h>
#include <formateur.h>

/* Variables d'environnement.                                                                */
int active_list=1;              /* Activation de la lsite d'assemblage.                      */
int pco=0; /* Définition du pseudo compteur ordinal.                                         */

/* Variables positionnées par le préparateur à la lecture du fichier syntaxe.                */
int casse_sens = 1;             /* Sensibilité de la syntaxe à la casse.                     */
char * fich_macro_def=NULL;     /* Nom du fichier de macros par défaut.                      */
char * define_str=NULL;         /* Chaine de caractères pour la déclaration de macros.       */
char * include_str=NULL;        /* Chaine de caractères pour la directive d'inclusion.       */
char * undef_str=NULL;          /* Chaine de caractères pour la suppression de macros.       */
type_lexeme * seplex=NULL;      /* Lexème séparateur entre les différentes instructions.     */
int nbr_sous_types=0;           /* Nombre de sous types admis par la syntaxe.                */
type_paire *regle_typage=NULL;  /* Table des règles et des codes de chaque sous-type.        */
