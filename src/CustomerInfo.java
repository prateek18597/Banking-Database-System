
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pratik
 */
public class CustomerInfo {
    protected static int CustomerId;
    protected static String name;
    protected static String address;
    protected static String dob;
    protected static String mobno;
    protected static String gender;
    protected static int accountno;
    protected static int balance;
    protected static String branchCode;
    protected static String branchName;
    protected static String bankName;
    protected static String doc;
    protected static String type;
    protected static String lastlogin;
    protected static String pass;
    protected static String tpass;
    protected static String UserId;
    protected static double interest;
    
    public static void fillDetails(String UserId) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        Statement stat1=null;
        ResultSet rs1=null;
        Statement stat2=null;
        ResultSet rs2=null;
        Statement stat3=null;
        ResultSet rs3=null;
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            stat1=myConn.createStatement();
            stat2=myConn.createStatement();
            stat3=myConn.createStatement();
            String query="Select * from NetbankingC where UserId='"+UserId+"'";
            rs=stat.executeQuery(query);
            if(rs.next())
            {
                CustomerInfo.accountno=rs.getInt(4);
                CustomerInfo.pass=rs.getString(2);
                CustomerInfo.tpass=rs.getString(3);
                CustomerInfo.lastlogin=rs.getString(5);
                CustomerInfo.UserId=rs.getString(1);
                String query1="Select Id,concat(FirstName,' ',LastName), DOB,";
                query1+=" Address, MobNo,Gender, Balance, DoC, Branch, Type";
                query1+=" from Customer,Account where Account.CustomerId=Id";
                query1+= " and AccountNo="+CustomerInfo.accountno;
                rs1=stat1.executeQuery(query1);
                if(rs1.next())
                {
                    CustomerInfo.CustomerId=rs1.getInt(1);
                    CustomerInfo.name=rs1.getString(2);
                    CustomerInfo.dob=rs1.getString(3);
                    CustomerInfo.address=rs1.getString(4);
                    CustomerInfo.mobno=rs1.getString(5);
                    CustomerInfo.gender=rs1.getString(6);
                    CustomerInfo.balance=rs1.getInt(7);
                    CustomerInfo.doc=rs1.getString(8);
                    CustomerInfo.branchCode=rs1.getString(9);
                    CustomerInfo.type=rs1.getString(10);
                    rs2=stat2.executeQuery("Select Interest from AccountType where Type='"+CustomerInfo.type+"'");
                    if(rs2.next())
                    {
                        CustomerInfo.interest=rs2.getDouble(1);
                    }
                    rs3=stat3.executeQuery("Select * from Bank where BranchCode='"+CustomerInfo.branchCode+"'");
                    if(rs3.next())
                    {
                        CustomerInfo.branchName=rs3.getString(2);
                    }
                    System.out.println("Retrieve Complete");
                }
            }
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
        }
    }
    
    public static void clearCustomerInfo()
    {
        CustomerId=0;
        name=null;
        address=null;
        dob=null;
        mobno=null;
        gender=null;
        accountno=0;
        balance=0;
        branchCode=null;
        branchName=null;
        bankName=null;
        doc=null;
        type=null;
        lastlogin=null;
        pass=null;
        tpass=null;
        UserId=null;
        interest=0.0;
    }
    
    public static int getBalance() throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            String query1="Select ";
            query1+=" Balance";
            query1+=" from Account where ";
            query1+= " AccountNo="+CustomerInfo.accountno;
            rs=stat.executeQuery(query1);
            
            if(rs.next())
            {
                    CustomerInfo.balance=rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
            return CustomerInfo.balance;
        }
    }
}
