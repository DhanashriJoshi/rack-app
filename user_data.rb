require 'mysql2'

class UserData
  def self.create
    begin
      con = Mysql2::Client.new(host: 'localhost', username: 'root')
      con.query("CREATE DATABASE IF NOT EXISTS rack_app")
      con = Mysql2::Client.new(host: 'localhost', username: 'root', database: 'rack_app')
      con.query("CREATE TABLE IF NOT EXISTS Users(Id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(255), email VARCHAR(25), contact_no VARCHAR(15))")
      con.query("INSERT INTO Users(name, email, contact_no) VALUES('Dhanashri Joshi', 'dhanashrijoshi@gmail.com', '+1234353')")
      con.query("INSERT INTO Users(name, email, contact_no) VALUES('Yukihiro Matsumoto', 'matz@yahoo.com', '+1241433')")
      con.query("INSERT INTO Users(name, email, contact_no) VALUES('Steve Jobs', 'steve@apple.com', '+23523134')")
      con.query("INSERT INTO Users(name, email, contact_no) VALUES('Rayson Mahindran', 'rayson@sg.com', '+1241245325')")
      con.query("INSERT INTO Users(name, email, contact_no) VALUES('Mahendra Singh', 'ms@bcci.com', '+17985788')")
    rescue Mysql2::Error => e
      p e.message
      p e.backtrace
    ensure
      con.close if con
    end
  end
end

UserData.create
