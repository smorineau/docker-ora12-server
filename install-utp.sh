sqlplus / as sysdba <<EOF
@create-utp-user.sql
EOF

mkdir -p utplsql
cp utplsql-2-3-0.zip utplsql/.
cd utplsql
unzip utplsql-2-3-0.zip
cd code

sqlplus utp/utp <<EOF
@ut_i_do install
EOF