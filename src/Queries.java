
import java.sql.Connection;
import java.sql.ResultSet;
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
   
    public static Boolean AccNoContactNo(String acc,String mob)
    {
        try
        {
            Connection myConn=null;
            Statement stat=null;
            ResultSet rs=null;
            String query="Select MobNo,AccountNo from Customer,Account where Customer.Id=Account.CustomerId and MobNo='"+mob+"' and AccountNo='"+acc+"'";
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
        }
        return false; 
    }
    
    public static Boolean UserIdAvailablility(String userId)
    {
        try
        {
            Connection myConn=null;
            Statement stat=null;
            ResultSet rs=null;
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
        }
        return false; 
    }
    
}
