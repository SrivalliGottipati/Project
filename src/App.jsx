import {Link, NavLink} from "react-router-dom"
import React,{useEffect,useState} from "react";
import image from "./background.png";
import 'bootstrap/dist/css/bootstrap.min.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faFacebook,faInstagram ,faTwitter,faLinkedin} from '@fortawesome/free-brands-svg-icons'

import "./App.css";



function Counter({name,limit}){
  const [count,setCount]=useState(0);

  useEffect(() =>{
      let interval;
      if(count < limit){
          interval = setInterval(() =>{
              setCount(prevCount => prevCount +1);
          },120);
      }
      return() => clearInterval(interval);
  },[count,limit]
  );
  return(
      <div className="category">
          <div className="count-container">
              <div className="count">{count}</div>
              <div className="plus">+</div>
          </div>
          <h3>{name}</h3>
          
      </div>
  );

}




export const App =() => {
    const [menuOpen,setMenuOpen]=useState(false)
    return(
      <div>
        <nav>
            <a href='#home' className='title'>Web Logic Labs</a>
            <div className='menu' onClick={() =>{
                setMenuOpen(!menuOpen)
            }}>
                <span></span>
                <span></span>
                <span></span>
            </div>
            <ul className={menuOpen ? "open":""}>
                <li>
                    <a href='#about' >About</a>
                </li>
                <li>
                <a href='#services' >Services</a>
                </li>
                <li>
                <a href='#clients' >Clients</a>
                </li>
                <li>
                <a href='#contact' >Contact</a>
                </li>
            </ul>
             </nav>




             <div className='main' style={{height:'100%',width:'100%'}} id="home">
    <div className='outer-div' style={{ backgroundImage:`url(${image})`,backgroundRepeat:"no-repeat",backgroundSize:"cover", 
    height:600}}>
     <div class="container-fluid">
     	<div class="column">
     		<div class="col-md-5 " >
     			<h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: 'white',fontSize:"50px",textShadow:'2px 2px 5px blue' }}>Your Vision </h1>
          <h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: 'white' ,paddingLeft:"5%",fontSize:"50px",textShadow:'2px 2px 5px blue'}}>Our Creation</h1>
     		</div>
         <div class="col-md-5 ">
     			<p style={{ fontFamily: 'Times New Roman, Times, serif' , color: 'white',fontSize:"20px" ,textShadow:'2px 2px 5px blue',textAlign:'justify'}}>
            we're your partners in navigating the dynamic landscape of online presence.
             With a fusion of creativity, technology, and innovation, we specialize in website design, 
            digital marketing, and cutting-edge Artificial Intelligence and Machine Learning solutions.</p>
     		</div>
     	</div>
     </div>
  </div>
  <div><h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingTop:'2%' }}>Experiences We've </h1>
          <h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingBottom:'2%'}}>Created</h1>
          </div>
  <div class="Container">
     	<div class="row">
     		<div class="col-md-4 " id='image-container'>
         <img src="images/img_1.jpg" alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">I am thoroughly impressed with the exceptional work done by Web Logic Labs. Their attention to detail and dedication to delivering high-quality solutions surpassed my expectations. I highly recommend their services to anyone seeking top-notch web development.</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>John Smith</h1>
     		</div>
     		


        < div class="col-md-4 " id='image-container'>
         <img src="images/img_2.jpg" alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">Working with Web Logic Labs has been an absolute pleasure. Their professionalism, expertise, and innovative approach have contributed significantly to the success of our projects. I look forward to collaborating with them on future endeavors.</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>Sarah Johnson</h1>
     		</div>
     		

         < div class="col-md-4 " id='image-container'>
         <img src="images/img_3.jpg" alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">The user-friendly interface and seamless functionality of the applications developed by Web Logic Labs have greatly enhanced my experience. Their commitment to excellence is evident in every aspect of their work. Kudos to the team for their outstanding contributions!</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>Jessica Martinez </h1>
     		</div>
     		

         < div class="col-md-4 " id='image-container'>
         <img src="images/img_4.jpg" alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">Working alongside the talented team at Web Logic Labs has been an enriching experience. Their collaborative spirit, professionalism, and dedication to excellence make them stand out in the industry. It's a privilege to be part of such a dynamic team!</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>David Thompson</h1>
     		</div>
     		

         < div class="col-md-4 " id='image-container'>
         <img src="images/img_5.jpg" alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">Web Logic Labs has consistently delivered outstanding results, exceeding our expectations every time. Their ability to understand our needs and translate them into robust solutions is commendable. I have complete confidence in their capabilities and would recommend them without hesitation.</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>Emma Brown</h1>
     		</div>
     		

         < div class="col-md-4 " id='image-container'>
         <img src="images/img_6.jpg"alt="Description of the image" style={{height:300,width:355,display:'block',margin:'auto'}} />
         <div id='content'>
         <p class="image-text">As an industry expert, I am continually impressed by the innovative solutions offered by Web Logic Labs. Their forward-thinking approach and commitment to staying at the forefront of technology make them a leader in the field. Keep up the fantastic work!</p>
         </div>
         <h1 style={{paddingTop:40,paddingBottom:40}}>Michael Harris</h1>
     		</div>
     	  


        <h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingTop:'2%' }}>Our Speciality </h1>
      
        <div class='col-md-3' >
            <Counter name="Projects Done" limit={77} /></div>
            <div class='col-md-4'>
            <Counter name="Websites Developed" limit={54} /></div>
            <div class='col-md-2'>
            <Counter name="Team" limit={18} /></div>
            <div class='col-md-3'>
            <Counter name="Happy Clients" limit={75} /></div>

     	</div> 
     </div>
  </div>







  <div class="containerprops" style={{paddingTop:'7%'}} id="about">
     	<div class="row">
     		<div class="col-md-6 ">
             <h1 style={{ fontFamily: 'Times New Roman, Times, serif' ,
              color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue'}}>About Us</h1>
              <hr/>
              <h3 style={{fontFamily: 'Times New Roman, Times, serif',color:'blue'}}>We Don't Just Build Websites;</h3>
              <h3 style={{fontFamily: 'Times New Roman, Times, serif',color:'blue'}}>We Build Relationships.</h3>
              <p style={{fontSize:18,textAlign:'justify'}}>Driven by passion and fueled by innovation, Web Logic Labs was founded with a vision to revolutionize 
                the digital space. Our team comprises seasoned professionals with diverse backgrounds 
                in web development, marketing, and AI technologies. We believe in staying ahead of the curve,
                 constantly exploring emerging trends and technologies to deliver exceptional results for our clients.</p>
     		</div>
           
     		<div class="col-md-6 ">
             <img src="images/img_4.jpg" alt="Description of the image" 
             style={{height:350,width:400,display:'block',margin:'auto'}} />	
     		</div>

             <h1 style={{ fontFamily: 'Times New Roman, Times, serif' ,
              color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingTop:20,paddingBottom:20}}>Why Choose Us ?</h1>
            
           
            <div class="col-md-4 " style={{backgroundColor:'#172554'}}>
     			<section >
                 <h2>Expertise</h2>
                    <p style={{fontSize:20,textAlign:'justify'}}>With years of experience under our belt, 
                        we possess the knowledge and skills to craft bespoke solutions that meet your unique needs.</p>
                </section>
     		</div>
     		<div class="col-md-4 " style={{backgroundColor:'#172554'}}>
     			<section >
                 <h2>Innovation</h2>
                    <p style={{fontSize:20,textAlign:'justify',wordSpacing:'2px'}}>We leverage the latest techno-logies, including AI and
                     machine learning, to provide cutting-edge solutions that give your business a competitive edge.</p>
                </section>
     		</div>
     		<div class="col-md-4 " style={{backgroundColor:'#172554'}}>
     			<section >
                 <h2>Personalized Approach</h2>
                    <p style={{fontSize:20,textAlign:'justify'}}>We understand that every business is unique. That's why we 
                    take a personalized approach to every project, ensuring that your vision is brought to life.</p>
                </section>
     		</div>

             <div class="col-md-4 " style={{backgroundColor:'#172554',paddingBottom:10}}>
     			<section  >
                 <h2>Results-Driven</h2>
                    <p style={{fontSize:20,textAlign:'justify'}}>Our success is measured by the success of our clients. We 
                    are committed to delivering tangible results that drive growth and maximize ROI.</p>
                </section>
     		</div>
     		<div class="col-md-4 " style={{backgroundColor:'#172554'}}>
     			<section  >
                 <h2>Customer-Centric</h2>
                    <p style={{fontSize:20,textAlign:'justify'}}>Your satisfaction is our top priority. We prioritize clear 
                    communication, transparency, and responsiveness throughout the entire process.</p>
                </section>
     		</div>
     		<div class="col-md-4 " style={{backgroundColor:'#172554'}}>
     			<section >
                 <h2>Tailored Solutions</h2>
                    <p style={{fontSize:20,textAlign:'justify'}}>We don't believe in one-size-fits-all approaches. Every 
                    solution we provide is custom-tailored to your specific goals and objectives.</p>
                </section>
     		</div>
</div> 
</div>








<div class="containerprops" style={{paddingTop:'2%'}} id="services">
            <div class="row">
     		<div class="col-md-12 ">
     		<h1 style={{ fontFamily: 'Times New Roman, Times, serif' ,
              color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingBottom:'1%'}}>Our capabilities</h1>
              <p style={{fontSize:30,}}>Whether you’re a start-up on the verge of something great or a Fortune 500 company looking 
                for a refresh, our full-service capabilities will allow you to reimagine the way you do digital.</p>	
     		</div>

             <h1 style={{ fontFamily: 'Times New Roman, Times, serif' ,
              color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingBottom:'1%'}}>Services</h1>
            
			 <h2>Website Development</h2><hr/>
     		<div class="col-md-7">
				<p style={{fontSize:20}}>Our company specializes in crafting exceptional websites that seamlessly blend captivating 
					design with intuitive functionality. With a keen focus on user experience, we create 
					websites that not only visually engage visitors but also guide them effortlessly through 
					the content. Our team of skilled designers and developers collaborates closely with clients
					 to understand their unique needs and goals, ensuring that each website we produce is tailored 
					 to their specifications. From responsive layouts to eye-catching visuals and streamlined 
					 navigation, we prioritize every detail to deliver websites that leave a lasting impression. 
					 With a commitment to innovation and excellence, we take pride in our ability to consistently 
					 exceed expectations and empower businesses to thrive in the digital landscape.
                </p>
     		</div>
     		<div class="col-md-5">
			 <img src="images/web.jpg" alt="Description of the image" style={{height:300,width:400,display:'block',margin:'auto'}} />
     		</div>

			 <h2 style={{paddingTop:20}}>Digital Marketing</h2><hr/>
     		<div class="col-md-5">
			 <img src="images/dm.jpg" alt="Description of the image" style={{height:300,width:400,display:'block',margin:'auto'}} />
     		</div>
     		<div class="col-md-7">
			 
     			<p style={{fontSize:20}}>
				 Our company is renowned for its expertise in digital marketing, offering comprehensive 
				 strategies that drive results and maximize ROI for our clients. With a deep 
				 understanding of the digital landscape, we leverage the latest tools and techniques
				 to create targeted campaigns that resonate with the intended audience. From search 
				 engine optimization (SEO) and pay-per-click (PPC) advertising to social media
				 marketing and email campaigns, we craft tailored solutions that enhance brand 
				 visibility and engagement across various platforms. Our data-driven approach enables
				 us to continually refine and optimize campaigns, ensuring optimal performance and
				 measurable success. With a track record of delivering impactful results, our 
				 team is dedicated to helping businesses thrive in today's competitive online environment.
				</p>
     		</div>
           
			 <h2 style={{paddingTop:20}}>AI/ML</h2><hr/>
             <div class="col-md-7">
     			<p style={{fontSize:20}}>
				 Our company excels in AI-powered personalization, harnessing cutting-edge technology 
				 to deliver tailored experiences that resonate with individual users. Through 
				 sophisticated algorithms and machine learning models, we analyze vast amounts of 
				 data to understand user behavior, preferences, and intent. This enables us to 
				 dynamically adjust content, product recommendations, and messaging in real-time, 
				 ensuring each interaction feels personalized and relevant. From personalized product 
				 recommendations on e-commerce platforms to curated content on media websites, we 
				 leverage AI to create meaningful connections that drive engagement and conversions.
				  With a focus on delivering exceptional user experiences, our AI personalization 
				  solutions empower businesses to connect with their audience on a deeper level and 
				  achieve unparalleled levels of customer satisfaction and loyalty.
				</p>
     		</div>
			 <div class="col-md-5">
     	    <img src="images/ai.jpg" alt="Description of the image" style={{height:300,width:400,display:'block',margin:'auto'}} />
     		</div>			 
</div>
</div>






<div className="moving-images-container" style={{paddingTop:'2%'}} id="clients">
<h1 style={{ fontFamily: 'Times New Roman, Times, serif' ,
              color: '#0f172a',fontSize:"50px",textShadow:'2px 2px 5px blue',paddingBottom:'1%'}}>Clients</h1>
      <marquee className="image-marquee" behavior="scroll" direction="left" scrollamount="3">
        <img src="images/image1.png" alt="Image 1" className="image" />
        <img src="images/image2.png"  alt="Image 2" className="image" />
        <img src="images/image3.png"  alt="Image 3" className="image" />
        <img src="images/image4.png"  alt="Image 4" className="image" />
        <img src="images/image5.png"  alt="Image 5" className="image" />
        <img src="images/image6.png"  alt="Image 6" className="image" />
        <img src="images/image7.png"  alt="Image 7" className="image" />
        <img src="images/image8.png"  alt="Image 8" className="image" />
      </marquee>
      
    </div>









    <div class="containerprops" style={{paddingTop:'2%'}} id="contact">
     	<div class="row">
<h1 style={{ fontFamily: 'Times New Roman, Times, serif' , color: '#0f172a',
fontSize:"50px",textShadow:'2px 2px 5px blue',paddingTop:'2%' }}>Let's Talk</h1>

<div class="col-md-4 " style={{backgroundColor:'#172554'}}>
    <h2 className='spec_1'>Web <span style={{color:'blue'}}>Logic</span> Labs</h2>
   </div>
   <div class="col-md-4 " id='loc_1'style={{backgroundColor:'#172554',paddingRight:90}}>
       <ul className='loc_2'>
  <li>1st Floor, Himayat Nagar Rd, opp. </li>
  <li> Kubera Towers, Hyderabad,</li>
  <li>Telangana 500029</li>
</ul>
   </div>
   <div class="col-md-4 "  style={{color:'white',backgroundColor:'#172554',paddingTop:15}}>
       <p >We'd love to learn more about you and work together toward a 
  profitable digital marketing strategy. Please get in touch with one of our Project Consultants.</p>
  <h3>Web@weblogiclabs.com</h3>
  <hr/>
  <ul className='loc_3'>
    <li>  <FontAwesomeIcon icon={faFacebook} /></li>
    <li><FontAwesomeIcon icon={faInstagram} /></li>
    <li><FontAwesomeIcon icon={faTwitter} /></li>
    <li><FontAwesomeIcon icon={faLinkedin} /></li>
  </ul>
   </div>

</div> 

  	</div>







      </div> 
    );
}
export default App;


