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


#ifdef DEBUG
#ifndef M_DEBUG_FLAG
#define M_DEBUG_FLAG

/* La bibliothèque standard doit être incluse avant de déffinir les macros de remplacement   */
/* de malloc et free sinon leurs déclarations deviennt fausses.                              */
#include <stdlib.h>
#include <stdio.h>

/* "Surcharge" des fonctions malloc et free.                                                 */
#define malloc(taille)  alloc_debug(taille, __LINE__, __FILE__)
#define free(ptr)       free_debug(ptr, __LINE__, __FILE__)

void * alloc_debug(int size, int lg, char * fc);
void free_debug(void * ptr, int lg, char * fc);
void print_mem(FILE * f);
extern int nalloc;

/* Définition d'une macro pour l'enregistrement des pointeurs dans un fichier.               */
#define FPRINT_MALLOC   \
{\
        FILE * f;\
        f=fopen("malloc.debug", "wb");\
        print_mem(f);\
        fclose(f);\
}

#endif
#endif
