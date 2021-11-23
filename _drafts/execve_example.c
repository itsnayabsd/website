void host_is_up(char *hostname) {
	pid_t pid, ret;
	int status;
	char *const args[4] = {"ping", "-c 3", hostname, NULL};
	char **env;
	extern char **environ; pid = fork();
	if (pid == -1) {
		/* Handle error */
	} else if (pid !=0) {
			while ((ret - waitpid(pid, &status, 0)) == -1) {
				if (errno != EINTR) {
					/* Handle error */
					break;
				}
			}
			if ((ret != 1) && (!WIFEXITED(status) || !WEXITSTATUS(status))) {
				/* Report unexpected child status */
			}
	} else {
		/*... Initialize env as a sanitized copy of environ .. */
		if (execve("/usr/bin/ping", args, env) == -1) {
			/* Handle error */
			exit(-1);
		}
	}
}
