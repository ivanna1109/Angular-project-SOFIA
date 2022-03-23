package com.nwp.izdavacka.security;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
 	UserDetailsService userDetailsService;
	
	@Bean
	public PasswordEncoder getPasswordEncoder() {
//		return NoOpPasswordEncoder.getInstance();
		return new BCryptPasswordEncoder();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
	    auth.userDetailsService(userDetailsService);
	}
	
	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
	    return super.authenticationManagerBean();
	}
	
	@Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration=new CorsConfiguration();
//      configuration.setAllowedOrigins(Arrays.asList("*"));
//      configuration.setAllowedOrigins(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
//      configuration.setAllowedOrigins(Arrays.asList("authorization", "content-type", "x-auth-token", "x-requested-with"));
      configuration.applyPermitDefaultValues();
      configuration.setExposedHeaders(Arrays.asList("X-AUTH-TOKEN"));
      UrlBasedCorsConfigurationSource source=new UrlBasedCorsConfigurationSource();
      source.registerCorsConfiguration("/**", configuration);
//                                              new CorsConfiguration().applyPermitDefaultValues()
      return source;
    }

	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable()
        .cors().and()
//        .addFilterBefore(corsFilter(), SessionManagementFilter.class)
        .authorizeRequests()
        .antMatchers("/auth/**", "/base/**", "/ang/**", "/angalb/**", "/angpes/**") //svaka putanja koja pocinje sa auth je dostupna svima
        .permitAll()    //dostupno svima
        .antMatchers("/unos/**")
        .hasRole("admin")
        .antMatchers("/pesme/**")
        .hasRole("user")
        .and()
        .formLogin()
        .loginPage("/auth/loginPage")
        .loginProcessingUrl("/login")
        .usernameParameter("username")
        .passwordParameter("password")
        .defaultSuccessUrl("/base/pocetna")
        .failureUrl("/auth/failure");
	}
}

