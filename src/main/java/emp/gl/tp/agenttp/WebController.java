package emp.gl.tp.agenttp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.UUID;

@RestController
public class WebController {
    private static final String ID = String.valueOf(UUID.randomUUID());

    @GetMapping ("/")
    public String sayHello ()
    {

        return "Hello to you \n\r" +
                "my ID is : " + ID + "\n\n" +
                "I am talking to you from IP address: " + getMyIP () ;
    }

    private String getMyIP() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            throw new RuntimeException(e);
        }
    }
}
