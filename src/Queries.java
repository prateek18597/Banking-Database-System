
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
public class Queries {
   
    public static Boolean AccNoContactNo(int acc,String mob) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            
            String query="Select MobNo,AccountNo from Customer,Account where Customer.Id=Account.CustomerId and MobNo='"+mob+"' and AccountNo="+acc+"";
            rs=stat.executeQuery(query);
            if(rs.next())
            {
                return true;
            }
            else
            {
                return  false;
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
        return false; 
    }
    
    public static Boolean UserIdAvailablility(String userId) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            
            String query="Select UserId from Netbanking where UserId='"+userId+"'";
            rs=stat.executeQuery(query);
            if(rs.next())
            {
                return false;
            }
            else
            {
                return  true;
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
        return false; 
    }
    
    public static Boolean InsertNetbanking(String UserId,String Password,
            String TransactionPassword,int AccountNo,String LastLogin,String Role) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            String query="Insert into Netbanking values ('"+UserId+"','"+Password+"','"+TransactionPassword+"',"+AccountNo+",curdate(),'"+Role+"')";
            stat.executeUpdate(query);
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
            return false;
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
            return true;
        }
    }
    
    public static Boolean InsertBeneficiary(int Acc,int BenAcc) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            String query="Insert into Beneficiary values ("+Acc+","+BenAcc+")";
            int k=stat.executeUpdate(query);
            if(k==0)
            {
                JOptionPane.showMessageDialog(null, "Beneficiary Addition Unsuccessful.");
            }
            else
            {
                JOptionPane.showMessageDialog(null, "Beneficiary Added Successfully.");
            }
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
            return false;
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
            return true;
        }
    }
    
    public static Boolean RemoveBeneficiary(int Acc,int BenAcc) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            String query="Delete from Beneficiary where AccountNo="+Acc+" and BeneAccount="+BenAcc;
            int k=stat.executeUpdate(query);
            if(k==1)
            {
                JOptionPane.showMessageDialog(null, "Beneficiary removed Successfully.");
            }
            else
            {
                JOptionPane.showMessageDialog(null, "Beneficiary removal unsuccessfully.");
            }
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
            return false;
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
            return true;
        }
    }
    
    public static Boolean MatchAccountContact(int acc,String mob) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        Boolean result=false;
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            
            String query="Select MobNo from Customer,Account where Customer.Id=Account.CustomerId and AccountNo="+acc;
            rs=stat.executeQuery(query);
            if(rs.next())
            {
                String m=rs.getString(1);
                if(m.equals(mob))
                    result=true;
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
        return result; 
    }
    
    public static Boolean TransferMoney(int Acc,int BenAcc,int amount) throws SQLException
    {
        Connection myConn=null;
        Statement stat=null;
        ResultSet rs=null;
        
        try
        {
            myConn=DriverManager.getConnection(Info.url,Info.user,Info.pass);
            myConn.setAutoCommit(false);
            stat=myConn.createStatement();
            String query="Update Account Set Balance=Balance-"+amount+" where AccountNo="+Acc;
            int k1=stat.executeUpdate(query);
            query="Update Account Set Balance=Balance+"+amount+" where AccountNo="+BenAcc;
            int k2=stat.executeUpdate(query);
            query="Insert into Transaction(FromAcc,ToAcc,Time,Amount) values("+Acc+","+BenAcc+",now(),"+amount+")";
            int k3=stat.executeUpdate(query);
            if(k1==0 || k2==0 || k3==0)
            {
                JOptionPane.showMessageDialog(null, "Money Transfer Unsuccessful.");
                myConn.rollback();
            }
            else
            {
                JOptionPane.showMessageDialog(null, "Money Transfer Successful.");
                myConn.commit();
            }
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, e.getMessage());
            myConn.rollback();
            return false;
        }
        finally
        {
            myConn.commit();
            stat.close();
            myConn.close();
            return true;
        }
    }
}
