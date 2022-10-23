#include<bits/stdc++.h>
using namespace std;

// first pair - startAppointmentTime, endAppointmentTime
// second pair - appointmentID, 0/1 - doctorAvailability
vector<pair<pair<int,int>, int>> doctorOccupiedTimes;

// # AppointmentOrder is the list we are fetching from the database, handling it as a queue
queue<int>AppointmentOrder;

class doctor{
    public:
    bool isAvailable;
    bool checkAvailabilityStatus(int currentTime){
        for(auto i: doctorOccupiedTimes)
        {
            if(currentTime>=i.first.first and currentTime<=i.first.second) return false;
        }
        return true;
    }
};

class patient{
    public:
    bool isAvailable;
};

class appointment{
   public:
   int id;
   int startTime;
   int endTime;
   int scheduledTime;
   bool isAttended;
};



vector<appointment> appointments;
map<int,int>attendedAppointments;    

void loadDoctorBusyHours(){
 for(int i=0;i<appointments.size();i++){
         appointment& currentAppointment = appointments[i];
         // ei time period er majhe doctor would be displayed as busy

         int s = currentAppointment.startTime =  currentAppointment.scheduledTime;
         int e = currentAppointment.endTime =  currentAppointment.scheduledTime + 30 ;

         doctorOccupiedTimes.push_back(make_pair(make_pair(s,e), currentAppointment.id)); 
    }
}

void rescheduleAppointment(int id){
    int s,e;
    pair<pair<int,int>,int> lastScheduledAppointment = doctorOccupiedTimes[doctorOccupiedTimes.size()-1] ;
    s = lastScheduledAppointment.first.first + 30;
    e = s + 30;
    for(auto &i: doctorOccupiedTimes)
    {
        if(i.second==id)
        {
            doctorOccupiedTimes.erase(doctorOccupiedTimes.begin() + id - 1);
            break; 
        }
    }
    doctorOccupiedTimes.push_back(make_pair(make_pair(s,e), id));
}


void printAppointmentList(){
     for(auto i:appointments)
     {
         cout<<i.startTime<<endl;
     }
}


void deleteAttendedAppointments(int id){
     for(int i=0;i<appointments.size();i++){
         appointment currentAppointment = appointments[i];
         if(id==currentAppointment.id)
         {
             appointments.erase(appointments.begin() + id - 1);
             break; 
         }
     }

}


void updateAppointmentStatus(int id){
     for(int i=0;i<appointments.size();i++){
         appointment& currentAppointment = appointments[i];
         if(id==currentAppointment.id)
         {
             currentAppointment.isAttended = true;
         }
    }   
}


void bookAppointment(){
    // notun keo appointment nite gele jodi age keo kono time e appintment niye thake tokhon appointment nite parbe na
    appointment appointment1;
    appointment1.id = 1;
    appointment1.scheduledTime = 10;
    appointment1.isAttended = false;
    
    appointment appointment2;
    appointment2.id = 2;
    appointment2.scheduledTime = 40;
    appointment2.isAttended = false;
    
    appointment appointment3;
    appointment3.id = 3;
    appointment3.scheduledTime = 70;
    appointment3.isAttended = false;
    
    appointments.push_back(appointment1);
    appointments.push_back(appointment2);
    appointments.push_back(appointment3);
}

signed main(){

    int patientAvailable;
    cin>> patientAvailable; // through chat system
    
    bookAppointment();
    loadDoctorBusyHours();
    printAppointmentList();
    cout<<endl;
    
    // currTime will be the startTime for any appointment
    int currTime = 20;
    doctor d1;
    int attendedAppointmentID = 1; //will be selected by doctor, fetched from database
    int doctorAvailable  = d1.checkAvailabilityStatus(currTime);
    
    if(doctorAvailable and patientAvailable and attendedAppointments[attendedAppointmentID] == 0)
    {
        deleteAttendedAppointments(attendedAppointmentID);
        attendedAppointments[attendedAppointmentID] = 1;
        doctorAvailable = 0;
        updateAppointmentStatus(attendedAppointmentID);
    }
    else if(!doctorAvailable or !patientAvailable and attendedAppointments[attendedAppointmentID] == 0)
    {
        rescheduleAppointment(attendedAppointmentID);
    }
    printAppointmentList();
    
}
