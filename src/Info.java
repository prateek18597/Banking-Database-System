/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pratik
 */
public class Info {
    static String user="root";
    static String pass="1111";
    static String currentUserId;
    static String UserId="";
    static String Role="";
    static String TransactionPassword="";
    static String AccountNo="";
    static String LastLogin="";
    static String url="jdbc:mysql://192.168.43.131:3306/Bank";

    public static void home()
    {
        if(Role.equals("Customer"))
        {
            new CustomerHome().setVisible(true);
        }
        else if(Role.equals("Employee"))
        {
         new EmployeeHome().setVisible(true);
        }
        else
        {
            new BankHome().setVisible(true);
        }
    }
}
