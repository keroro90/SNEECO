subroutine tracking(t)

use parameters
use droplets
double precision :: f_corr
integer :: i,t

!! new position
do i=1,n_p
  x_new(i)=x(i) + u(i)*dt
  y_new(i)=x(i) + v(i)*dt
  ! update position
  x(i)=x_new(i)
  y(i)=y_new(i)
enddo

print*,'Tracking droplets      - step',t

do i=1,n_p
  rep(i)=rho_g*d(i)*sqrt((u(i)-u_f(i))**2 + (v(i)-v_f(i))**2)/mu_g
  !if (i.eq.1) print*,'rep',rep(i)
  if (isnan(rep(i))) stop 'Instability-----STOP STOP STOP'
  f_corr=1d0 + 0.15d0*rep(i)**(0.687d0)
  !if (i.eq.1) print*,'f_corr',f_corr
  taup(i)=rho_l*d(i)**2d0/(18*mu_g)
  rhsx(i)=f_corr/taup(i)*(u_f(i)-u(i))
  rhsy(i)=f_corr/taup(i)*(v_f(i)-v(i))- (1d0-rho_g/rho_l)*g
  !if (i.eq.1) print*,'rhsx',rhsx(i),'rhsy',rhsy(i)
  u_new(i)=u(i) + rhsx(i)*dt
  v_new(i)=v(i) + rhsy(i)*dt
  !update velocity
  u(i)=u_new(i)
  v(i)=v_new(i)
  !if (i.eq.1) print*,'u_i',u(i),'v_i',v(i)
enddo

return
end
