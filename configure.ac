#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

dnl Disable caching
define([AC_CACHE_LOAD],)
define([AC_CACHE_SAVE],)

AC_PREREQ([2.65])
AC_INIT( [NoMa], [2.0.0-dev], [https://www.netways.org/projects/noma/] )

AC_PREFIX_DEFAULT(/usr/local/noma)

AM_INIT_AUTOMAKE([ foreign ])


# Checks for programs.
AC_PROG_INSTALL
AC_PROG_GREP
AC_PROG_SED

# Check for php

# Check for mysql



# Users for webfiles
AC_DEFUN([ACNOMA_USER_GUESS],[
   $2=$3
   for x in $1; do
    AC_MSG_CHECKING([if user $x exists])
     AS_IF([ $GREP -q "^$x:" /etc/passwd ],
           [ AC_MSG_RESULT([found]); $2=$x ; break],
           [ AC_MSG_RESULT([not found]) ])
   done
  ])

AC_DEFUN([ACNOMA_GROUP_GUESS],[
   $2=$3
   for x in $1; do
    AC_MSG_CHECKING([if group $x exists])
     AS_IF([ $GREP -q "^$x:" /etc/group ],
           [ AC_MSG_RESULT([found]); $2=$x ; break],
           [ AC_MSG_RESULT([not found]) ])
   done
])

AC_ARG_WITH([web_user],
        AS_HELP_STRING([--with-web-user=USER], [username for web writable files (default www-data)]),
        web_user=$withval,
        ACNOMA_USER_GUESS([www wwwrun www-data apache httpd nobody],[web_user],[www-data])
)

AC_ARG_WITH([web_group],
        AS_HELP_STRING([--with-web-group=GROUP], [group for web writable files (default www-data)]),
        web_group=$withval,
        ACNOMA_GROUP_GUESS([www www-data apache httpd nogroup nobody],[web_group], [www-data])
)
AC_SUBST(web_user)
AC_SUBST(web_group)

INSTALL_OPTS_WEB="-o $web_user -g $web_group"
AC_SUBST(INSTALL_OPTS_WEB)

dnl Check for location of Apache conf.d directory
HTTP_CONF=no
AC_ARG_WITH(httpd_conf,AC_HELP_STRING([--with-httpd-conf=<path_to_conf>],[sets path to Apache conf.d directory]),HTTPD_CONF=$withval,HTTPD_CONF=no)
if test x$HTTPD_CONF = xno; then
	if test -d /etc/httpd/conf.d; then
		HTTPD_CONF="/etc/httpd/conf.d"
	elif test -d /etc/apache2/conf.d; then
		HTTPD_CONF="/etc/apache2/conf.d"
	elif test -d /etc/apache/conf.d; then
		HTTPD_CONF="/etc/apache/conf.d"
	else
		HTTPD_CONF="/etc/httpd/conf.d"
	fi
fi
AC_SUBST(HTTPD_CONF)


dnl ################
dnl LOG DIRS
dnl ################
dnl Location of logging path
LOGDIR=no
AC_ARG_WITH(log-dir,AC_HELP_STRING([--with-log-dir=<path>],[sets path to logging directory]),LOGDIR=$withval,LOGDIR=no)
if test x$LOGDIR = xno; then
        LOGDIR="$localstatedir"
fi
AC_SUBST(LOGDIR)

dnl Check for location of init scripts
init_dir=/etc/rc.d/init.d
if test -d /etc/rc.d/init.d; then
	init_dir="/etc/rc.d/init.d"
elif test -d /usr/local/etc/rc.d; then
	init_dir="/usr/local/etc/rc.d"
elif test -d /etc/rc.d; then
	init_dir="/etc/rc.d"
elif test -d /etc/init.d; then
	init_dir="/etc/init.d"
elif test -d /sbin/init.d; then
	init_dir="/sbin/init.d"
fi

dnl User can override init script location
AC_ARG_WITH(init_dir,AC_HELP_STRING([--with-init-dir=<path>],[sets directory to place init script into]),init_dir=$withval)
AC_SUBST(init_dir)

dnl User can override lock file location
AC_ARG_WITH(lockfile,AC_HELP_STRING([--with-lockfile=<path>],[sets path and file name for lock file]),lockfile=$withval,lockfile=$localstatedir/noma.lock)
AC_SUBST(lockfile)

dnl htmurl
AC_ARG_WITH(htmurl,AC_HELP_STRING([--with-htmurl=<local-url>],[sets URL for public html]),htmurl=$withval,htmurl=/noma)
AC_SUBST(htmurl)

dnl databases
USE_MYSQL=yes
USE_PGSQL=no
USE_ORACLE=no
USE_SQLITE3=no
USE_WHICH_RDBMS="mysql"

AC_ARG_ENABLE(oracle,AC_HELP_STRING([--enable-oracle],[enables oracle]),USE_ORACLE=$enableval,USE_ORACLE=no)
AC_ARG_ENABLE(pgsql,AC_HELP_STRING([--enable-pgsql],[enables pgsql]),USE_PGSQL=$enableval,USE_PGSQL=no)
AC_ARG_ENABLE(mysql,AC_HELP_STRING([--enable-mysql],[enables mysql]),USE_MYSQL=$enableval,USE_MYSQL=no)
AC_ARG_ENABLE(sqlite3,AC_HELP_STRING([--enable-sqlite3],[enables sqlite3]),USE_SQLITE3=$enableval,USE_SQLITE3=no)

if test x$USE_MYSQL = xyes; then
	USE_WHICH_RDBMS="mysql"
fi
if test x$USE_PGSQL = xyes; then
        USE_WHICH_RDBMS="pgsql"
fi
if test x$USE_ORACLE = xyes; then
        USE_WHICH_RDBMS="oracle"
fi
if test x$USE_SQLITE3 = xyes; then
        USE_WHICH_RDBMS="sqlite3"
fi

AC_SUBST(USE_WHICH_RDBMS)



# Checks for libraries.

PERLLIBS="`perl -MExtUtils::Embed -e ldopts`"
PERLDIR="`perl -MConfig -e 'print $Config{installsitearch}'`"

AC_PATH_PROG(PERL,perl)
noma_perl="$PERL"
AC_SUBST(noma_perl)

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.


#AC_OUTPUT(Makefile doc/Makefile etc/Makefile notifier/Makefile contrib/Makefile sql/Makefile share/Makefile)
AC_OUTPUT

AC_CONFIG_FILES(Makefile etc/NoMa.yaml etc/httpd.conf)

AC_PROG_INSTALL

dnl Review options
echo ""
echo ""
AC_MSG_RESULT([*** Configuration summary for $PACKAGE_NAME $PACKAGE_VERSION ***:])

echo ""
echo " General Options:"
echo " -------------------------"

AC_MSG_RESULT([        Apache user/group:  $web_user,$web_group])
AC_MSG_RESULT([       Install \${prefix}:  $prefix])
AC_MSG_RESULT([          Install Htm Url:  $htmurl])
AC_MSG_RESULT([                Lock file:  $lockfile])
AC_MSG_RESULT([            Log directory:  $LOGDIR])
AC_MSG_RESULT([           Init directory:  $init_dir])
AC_MSG_RESULT([  Apache conf.d directory:  $HTTPD_CONF])
AC_MSG_RESULT([               Rdbms used:  $USE_WHICH_RDBMS])

echo ""
echo ""

