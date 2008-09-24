/***************************************************************************/
/***     Include files.                                                  ***/
/***************************************************************************/

#include "pager_clerk.h"


/***************************************************************************/
/***     Usage statement.                                                ***/
/***************************************************************************/

void print_usage(void)
{
                                        /* Print out the usage stmt.      */
                                        /* Exit from the program.         */
  printf("\nUsage: pager_clerk (-d (-p -m -t)|-o)\n");
  printf("\n where:\n");
  printf("   -p <pager_type>         Is one of: SKY_PAGER (numeric)\n");
  printf("                                      DIGITAL (digial)\n");
  printf("                                      SKY_WORD (text)\n");
  printf("   -t <pager_number>       Is the pager number for RPA or Pagemate\n");
  printf("   -m <message>            Is the text message for text paging\n");
  printf("   -o <objid>              Is the objid of the table_page_request\n");
  printf("                            row already created by the page req API\n");
  printf("   -d <date>               Alternate date/time to use in file name\n");
  printf("                            (used for repaging with original date/time).\n");
  printf("                            Replaces current date/time (default).\n\n");
  exit(EXIT_ERROR);
}

/***************************************************************************/
/***     Main Routine.                                                   ***/
/***************************************************************************/

void main(int argc, char *argv[])
{
  short      cur_arg;                   /* Looping variable for current arg*/
  char       switch_char;               /* First char of option.           */
  char       file_name[50];             /* File name to create.            */
  FILE      *out_file;                  /* Output file to write to.        */
  short      mes_len;                   /* Message length.                 */
  char      *out_dir;                   /* Output directory from env var.  */
  char       total_path[500];           /* Total path to output file.      */
  int pid;
  int fileId;
  GUID guid;                                      
  char *str;
					/* If they called the pgm with no  */
                                        /*  aguments...                    */
                                        /*  Print an error and the usage.  */
  if (argc == 1)
  {
     printf("%s\n", NO_ARGS);
     print_usage();
  }

                                        /* Clear out important variables.  */
  strcpy(pager_type, "");
  strcpy(pager_number, "");
  strcpy(message, "");
  strcpy(email_addr, "");
  strcpy(objid, "");
  strcpy(date_time, "");

                                        /* For each option in cmd line...  */
                                        /*  Get first char of switch.      */
                                        /*  If not a dash or slash...      */
                                        /*   Error, usage, and exit.       */
                                        /*  If no switch letter, error.    */
  for (cur_arg = 1; cur_arg < argc; cur_arg++)
  {
      switch_char = argv[cur_arg][0];
      if (switch_char == '&' && cur_arg == argc - 1)
        continue;
      if ((switch_char != DASH) && (switch_char != SLASH))
	  {
         sprintf(err_msg, BAD_SWITCH, cur_arg, argv[cur_arg]);
         printf("%s\n", err_msg);
         print_usage();
      }
	  if (strlen(argv[cur_arg]) == 1)
      {
         sprintf(err_msg, NO_SWITCH, cur_arg);
         printf("%s\n", err_msg);
         print_usage();
	  }

	                                    /* Look at the first letter. If    */
	                                    /*  is no value following, error.  */
	                                    /* Else, save in proper variable.  */
      switch (argv[cur_arg][1])
	  {
	    case 'p' : 
		    if (cur_arg == argc - 1)
			{
			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			}			
		    strcpy(pager_type, argv[++cur_arg]);
		    break;
	    case 't' :
		     if (cur_arg == argc - 1)
			 {
   			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			 }
		     strcpy(pager_number, argv[++cur_arg]);
		     break;
        case 'm' :
		    if (cur_arg == argc - 1)
			{
			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			}
		    strcpy(message, argv[++cur_arg]);
		    break;
        case 'e' :
		    if (cur_arg == argc - 1)
			{
			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			}
		    strcpy(email_addr, argv[++cur_arg]);
		    break;
        case 'o' :
		    if (cur_arg == argc - 1)
			{
			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			}
		    strcpy(objid, argv[++cur_arg]);
		    break;
		case 'd':
            if (cur_arg == argc - 1)
			{
			   sprintf(err_msg, MISSING_ARG, cur_arg);
		       printf("%s\n", err_msg);
			   print_usage();
			}
			strcpy(date_time, argv[++cur_arg]);
			break;
	  }
  }

                                        /* If this is an API call, write   */
                                        /*  the output file.               */
  if (strlen(objid) > 0)
  {
     goto write_it;
  }

                                        /* If no pager number, error.      */
  if (strlen(pager_number) == 0)
  {
	 printf("%s\n", MISSING_NUMBER);
	 print_usage();
  }

                                        /* If not a valid pager type, error*/
  if ((strcmp(pager_type, "SKY_WORD") != 0) && (strcmp(pager_type, "DIGITAL") != 0) && \
	  (strcmp(pager_type, "SKY_PAGER") != 0))
  {
     sprintf(err_msg, BAD_TYPE, pager_type);
	 printf("%s\n", err_msg);
	 print_usage();
  }

                                        /* If no message, error.           */
  if (strlen(message) == 0)
  {
     printf("%s\n", MISSING_MESSAGE);
     print_usage();
  }

write_it:

                                        /* Build up a unique file name       */
                                        /* On UNIX, use the PID (process id) */                                     
                                        /* On Windows, use a GUID            */                                       
                                        
pid = 0;
fileId = 0;
	
#ifdef UNIX
	 pid = getpid()
	  do 
	  {
		fileId++;	  		
		sprintf(file_name, "fcspr.%d_%d.req", pid,fileId);
	  } while (file_exists(file_name) == TRUE);

#else
	 UuidCreate(&guid);
	 UuidToString(&guid,&str);
	 sprintf(file_name, "fcspr.%s.req", str);
	 RpcStringFree(&str);
#endif


                                        /* Get output directory env var.   */
                                        /* If not defined, assume cur dir. */
                                        /* Else, build total path putting  */
                                        /*  in extra backslash if needed.  */
  out_dir = getenv("FCS_PAGING_REQUEST_DIR");
  if (out_dir == NULL)
  {
	 strcpy(total_path, file_name);	 
  }
  else
  {
	  if (out_dir[strlen(out_dir) - 1] != DIR_SLASH)
	  {
		 sprintf(total_path, "%s%c%s", out_dir, DIR_SLASH, file_name);
	  }
	  else
	  {
	  sprintf(total_path, "%s%s", out_dir, file_name);
	  }
  }


                                        /* Open the output file.           */
                                        /* If can't, error and leave.      */
  out_file = fopen(total_path, "w+");
  if (out_file == NULL)
  {
	 sprintf(err_msg, NOT_OPEN, file_name);
	 printf("%s\n", err_msg);
	 exit(EXIT_ERROR);
  }

                                        /* If this is an API call, write   */
                                        /*  the output to the file, else   */
                                        /*  write the version from the     */
                                        /*  standard business rule pager.  */
                                        /* Close output file.              */
  if (strlen(objid) > 0)
  {
	 fprintf(out_file, "API       ");
	 fprintf(out_file, "%s", objid);
  }
  else
  {
     fprintf(out_file, "NOTIFY    ");
     fprintf(out_file, "%-40s", pager_number);
     mes_len = strlen(message);
     fprintf(out_file, "%-5d", mes_len);
     fprintf(out_file, "%s", message);
  }
  fclose(out_file);

                                        /* Everything was OK!!!            */
  exit(EXIT_NORMAL);
}



int file_exists(const char *filename)
{
	FILE *file;
	if (file = fopen(filename, "r"))
	{
		fclose(file);
		return TRUE;	
	}
	return FALSE;
		
}


