// Get an instance of mysql we can use in the app
const mysql = require('mysql2')

// Create a 'connection pool' using the provided credentials
const pool = mysql.createPool({
    host            : 'localhost',
    user            : 'root',
    password        : 'Waterpolo##47650974',
    database        : 'planner'
})

pool.getConnection((err, connection) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to MySQL database as ID:', connection.threadId);
    connection.release();  // Release the connection back to the pool
});

// Export it for use in our application
module.exports.pool = pool;
