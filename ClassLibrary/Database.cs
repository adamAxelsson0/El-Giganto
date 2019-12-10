using System;
using System.Data.SqlClient;
using Dapper;

namespace ClassLibrary
{
    public class Database
    {
        private readonly string connectionString;
        public Database(string connectionString)
        {
            this.connectionString = connectionString;
        }
    }
}
