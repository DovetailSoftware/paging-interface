/***************************************************************************/
/***     Include files.                                                  ***/
/***************************************************************************/

#include <stdlib.h>                     /* Standard include files.         */
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#ifdef UNIX
#include <unistd.h>
#else
#include <process.h>
#include <Rpc.h>
#include <Rpcdce.h>
#endif




/***************************************************************************/
/***     Functional prototypes                                           ***/
/***************************************************************************/

/***************************************************************************/
/***     Global definitions.                                             ***/
/***************************************************************************/

					                    /* Boolean values.                 */
#ifndef TRUE
#define TRUE          1
#define FALSE         0
#endif

                                        /* Exit return codes.              */
#define EXIT_NORMAL   0                
#define EXIT_ERROR    1

                                        /* Character constants.            */
#define DASH          '-'
#define SLASH         '/'
#ifdef UNIX
#define DIR_SLASH     '/'
#else
#define DIR_SLASH     '\\'
#endif

/***************************************************************************/
/***     Messages.                                                       ***/
/***************************************************************************/

                                        /* Command-line parsing messages.  */
#define NO_ARGS    "\nNo arguments supplied."
#define BAD_SWITCH                                                           \
        "\nArgument %d (%s). Option must start with a dash '-' or slash '/'."
#define NO_SWITCH  "\nArgument #%d has no switch letter."
#define MISSING_ARG                                                          \
        "\nArgument %d. Argument is missing the value."
#define BAD_TYPE                                                             \
        "\nPager type (%s) not one of valid values: SKY_WORD, DIGITAL, SKY_PAGER."
#define MISSING_NUMBER "\nPager number not supplied with -t argument"
#define MISSING_MESSAGE "\nText message not supplied with -m argument"
#define NOT_OPEN "Could not open page request file (%s) for writing"

/***************************************************************************/
/***     Global Variables.                                               ***/
/***************************************************************************/

struct tm *file_time;                   /* Time used for file name         */
time_t     file_time_t;                 /* Time used for file name.        */
char       file_time_str[80];           /* String to build file name       */

char err_msg[255];                    /* Error message.                  */
char pager_type[10];                    /* Pager type.                     */
char pager_number[40];                  /* Pager number.                   */
char email_addr[80];                    /* Email address.                  */
char objid[10];                         /* Objid for API version.          */
char message[2000];                     /* Text message for pager.         */
char date_time[80];                     /* Alternate date/time for filename*/

int file_exists(const char *filename);

