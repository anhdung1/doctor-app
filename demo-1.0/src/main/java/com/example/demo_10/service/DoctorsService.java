package com.example.demo_10.service;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo_10.model.Appointments;
import com.example.demo_10.model.Doctors;
import com.example.demo_10.model.UserInfo;
import com.example.demo_10.repository.DoctorsRepository;

@Service
public class DoctorsService {
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private DoctorsRepository doctorsRepository;
	public boolean removeFavoriteDoctor(String username, Long doctorId) {
	    UserInfo useInfo = userInfoService.findUserInfoByUsername(username);
	    Doctors doctor = doctorsRepository.findById(doctorId).orElse(null);

	    if (useInfo != null && doctor != null) {
	 
	        boolean removed = useInfo.getFavoriteDoctors().remove(doctor);
	        if (removed) {
	        	userInfoService.saveUserInfo(useInfo); 
	            return true;
	        } else {
	            return false;
	        }
	    }
	    return false; 
	}
	public List<Doctors> findByCategoryContaining(String category) {
		return	doctorsRepository.findByCategoryContaining(category);
	}
	
	public Doctors findById(Long doctorId) {
		return doctorsRepository.findById(doctorId).orElseThrow();
	}
	public List<Appointments> getApointment(Long doctorId) {

		Doctors doctor=doctorsRepository.findById(doctorId).orElseThrow();
		List<Appointments> appointments=new ArrayList<Appointments>();
		for(Appointments appointment:doctor.getAppointments()) {
			if(appointment.getUsers()==null) {
				appointments.add(appointment);
			}
		}
		return appointments;
	}
	public List<Doctors>findRandomDoctor(){
		return doctorsRepository.findRandomDoctors();
	}

}