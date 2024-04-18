#Library management system
create database LibraryData;
use LibraryData;
#1. Branch
create Table Branch(Branch_no int primary key,Manager_id int not null, Branch_address varchar(20), Contact_no char(10));
#2. Employee
create Table Employee(Emp_id int primary key, Emp_name varchar(20), Position varchar(20), salary int, Branch_no int,foreign key(Branch_no)references Branch(Branch_no));
#3. Customer
create Table Customer(Customer_id int primary key, Customer_name varchar(20), Customer_adress varchar(20), Reg_date date);
#4. IssueStatus
create Table IssueStatus(Issue_id int primary key, Issued_cust int,foreign key(Issued_cust)references Customer(Customer_id), Issued_book_name varchar(20),Issued_date date, Isbn_book int, foreign key(Isbn_book)references Book(Isbn));
#5. ReturnStatus
create Table ReturnStatus(Return_id int primary key, Return_cust int,Return_book_name varchar(20), Return_date date, Isbn_book2 int,foreign key(Isbn_book2)references Book(Isbn));
#6. Books
create Table Books(Isbn int primary key, Book_title varchar(20), Catogery varchar(20), Rental_price int, Status enum('yes', 'no'), Author varchar(20), Publisher varchar(20));
insert into Branch(Brancho_no, Manager_id, Branch_address, Contact_no)values(1, 121, 'ijk123', 6789568810),
                                                                            (2, 222, 'tsr345', 1234567899),
                                                                            (3, 333, 'ekm678', 7486980912),
                                                                            (4, 444, 'kdl987', 3456789012);
insert into Employee(Emp_id, Emp_name,Position, Salary, Branch_no)values(121,'john', 'librarian', 50000, 1),
																		(222, 'merry', 'assistant librarian', 45000,1),
                                                                        (333, 'dani', 'library_clerk_cum_typist', 30000,1),
                                                                        (444, 'deysi', 'library attendant', 30000,1);
insert into customer(Customer_id, Customer_name, Customer_adress, Reg_date)values(34, 'mariya', 'tvm123', 08-03-2012),
																				  (35, 'sincy', 'mpm345', 09-04-2012),
                                                                                  (36, 'abyan', 'tsr436', 10-05-2013),
                                                                                  (37, 'aidhan', 'kdps5', 11-06-2013);
insert into IssueStatus(Issue_id, Issued_cust, Issued_book_name, Issued_date, Isbn_book)values(444, 304, 'RAM c\o ANADHI', 7-12-2020, 9843562222222),
																							  (555, 270, 'ETTAVUM PRIYAPETTA ENNOD', 19-12-2023, 9788196510565),
                                                                                              (666, 315, 'RUTHINTE LOKAM', 28-02-2024, 9789353900281),
                                                                                              (777, 565, 'FRANCIS ITTIKKORA', 20-03-2024, 97881264245);
insert into ReturnStatus(Return_id, Return_cust, Return_book_name, Return_date, Isbn_book2)values(401, 304,'RAM c\o ANADHI', 1-12021, 9843562222222),
																								 (402, 270, 'ETTAVUM PRIYAPETTA ENNOD', 2-2-2024, 9788196510565),
                                                                                                 (403, 315,  'RUTHINTE LOKAM', 1-3-2024, 9789353900281),
                                                                                                 (404, 565, 'FRANCIS ITTIKKORA', 28-3-2024, 97881264245);
insert into Books(Isbn, Book_title, Catogery, Rental_price, Author, Publisher)values( 9843562222222, 'RAM c\o ANADHI', 'novel', 349,'yes', 'akhil p dharmajan','dc books'),
                                                                                    ( 9788196510565, 'ETTAVUM PRIYAPETTA ENNOD', 'novel', 350, 'yes', 'nimnavijay', 'mankind publications'),  
                                                                                    ( 9789353900281, 'RUTHINTE LOKAM','crime thriller', 225, 'yes', 'lajo jose','dc books'),
                                                                                    ( 97881264245,  'FRANCIS ITTIKKORA', 'rush hours', 210, 'yes', 't d ramakrishnan', 'dc books');
                                                                                    
#1. Retrieve the book title, category, and rental price of all available books 
select Book_title, Catogery, Rental_price from Books where status = 'yes';

#2. List the employee names and their respective salaries in descending order of salary
select Emp_name, Salary from Employee order by Salary desc;

#3. Retrieve the book titles and the corresponding customers who have issued those books
select Books.Book_title,Customer.Customer_name from IssueStatus inner join Books on IssueStatus.Isbn_book = Books.ISBN join Customer on IssueStatus.Issued_cust = Customer.Customer_Id;

#4. Display the total count of each catogery
select Catogery,count(*) as total_count from Books group by Catogery;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select Emp_name, Position, Salary from Employee where Salary>50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
select Customer_name,Reg_date from Customer where Reg_date< 2022-01-01 and Customer_id not in (select Issued_cust from IssueStatus);

#7. Display the branch numbers and the total count of employees in each branch
select Branch_no,count(*) as total_count from Employee group by branch;

#8. Display the names of customers who have issued books in the month of June 2023.
select Issued_cust from IssuedStatus where Issued_date=01-06-2023 and Issued_date=30-06-2023 in (select Customer_name from Customer);

#9.  Retrieve book_title from book table containing history
select Book_title from Books where Catogery = 'HISTORY';
 
#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
select Branch_no,count(*) as count_employee from employee group by Branch_no having count(*)>5;

