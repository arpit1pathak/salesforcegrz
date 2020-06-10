public class trishusession1controller {

 public List<account> accList{get;set;}
 public Boolean outputviewer{get;set;}
 public Boolean inputviewer{get;set;}

public trishusession1controller(){
        
        accList = [select id,name from account];
    outputviewer= true;
        inputviewer = false;
    }


    public PageReference Cancel() {
        outputviewer= true;
        inputviewer = false;
        return null; 
    }


    public PageReference Save() {
    update acclist;
    outputviewer= true;
        inputviewer = false;
        return null;
    }


    public PageReference editer() {
    outputviewer= false;
        inputviewer = true;
        return null;
    }

   
    
    
    

}