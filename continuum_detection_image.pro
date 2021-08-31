pro continuum


  ra_center=ten(20,58,17.03)*15.
  dec_center=ten(43,53,43.4)

  
  set_plot,'ps'
  device,/color,bits=8,filename='hbc722_alma.eps',/port,/encaps,xsize=15,ysize=15
  !p.thick=4.0
  !x.thick=4.0
  !y.thick=4.0
  !p.charthick=4.0
  !p.charsize=1.0



  ;plot the background color image
  fits_read,'HBC722_selfcal3.image.fits',image,header  
  sky,image,skyvalue,skyerr,/silent
  extast,header,astrom_alma
  imagemin=-0.001 & imagemax=0.001
  xmin=154 & xmax=454 & ymin=154 & ymax=454
  xy2ad,xmin,ymin,astrom_alma,amin,dmin
  xy2ad,xmax,ymax,astrom_alma,amax,dmax
  ra_offset_min=(amin-ra_center)*3600.*cos(dec_center*!pi/180.)
  ra_offset_max=(amax-ra_center)*3600.*cos(dec_center*!pi/180.)
  dec_offset_min=(dmin-dec_center)*3600.
  dec_offset_max=(dmax-dec_center)*3600.
  pos=[0.1,0.1,0.9,0.9]
  image2=(image(*,*)-imagemin)/(imagemax-imagemin)
  w=where(image2 gt 1.0,count) & if count gt 0 then image2[w]=1.0
  w=where(image2 lt 0.0,count) & if count gt 0 then image2[w]=0.0
  loadct,1
  tvscale,image2(xmin:xmax,ymin:ymax),pos=pos,minvalue=0.0,maxvalue=1.0
  loadct,0

  ;add the coordinate axis
  plot,[xmin,xmax],[ymin,ymax],/noerase,/nodata,xstyle=5,ystyle=5,pos=pos,color=0 ;,background=white,pos=pos
  axis,xaxis=0,xrange=[ra_offset_min,ra_offset_max],/xstyle,xtitle='R.A. Offset (arcseconds)'
  axis,xaxis=0,xrange=[ra_offset_min,ra_offset_max],/xstyle,xtickformat="(a1)",color=299
  axis,xaxis=1,xrange=[ra_offset_min,ra_offset_max],/xstyle,xtickformat="(a1)",color=299
  axis,yaxis=0,yrange=[dec_offset_min,dec_offset_max],/ystyle,ytitle='Decl. Offset (arcseconds)'
  axis,yaxis=0,yrange=[dec_offset_min,dec_offset_max],/ystyle,ytickformat="(a1)",color=299
  axis,yaxis=1,yrange=[dec_offset_min,dec_offset_max],/ystyle,ytickformat="(a1)",color=299

  ;add the primary beam
  pbeam_x=dindgen(100.)*2.*!pi/99.
  pbeam_y=dindgen(100.)*2.*!pi/99.
  pbeam_fwhm_arcsec=1.22*(2.99792458d8/230.0d9)/12.*180./!pi*3600.
  pbeam_hwhm_arcsec=pbeam_fwhm_arcsec/2.0
  pbeam_hwhm_pixel=pbeam_hwhm_arcsec/0.25
  pbeam_ra=cos(pbeam_x)*pbeam_hwhm_arcsec
  pbeam_dec=sin(pbeam_y)*pbeam_hwhm_arcsec
  pbeam_x=cos(pbeam_x)*pbeam_hwhm_pixel
  pbeam_y=sin(pbeam_y)*pbeam_hwhm_pixel
  loadct,13
  oplot,pbeam_x+299.5,pbeam_y+299.5,thick=6,color=200
  loadct,0

  ;add labels
  xyouts,(-10*(-1.0)/0.25+299.5),(30/0.25+299.5),'MMS1',color=299
  xyouts,(-10*(-1.0)/0.25+299.5),(27/0.25+299.5),'30 mJy',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(13/0.25+299.5),'HBC722',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(10/0.25+299.5),'3.0 mJy',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(1/0.25+299.5),'MMS8',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(-2/0.25+299.5),'5.1 mJy',color=299
  xyouts,(30*(-1.0)/0.25+299.5),(0/0.25+299.5),'MMS2',color=299
  xyouts,(30*(-1.0)/0.25+299.5),(-3/0.25+299.5),'9.5 mJy',color=299
  xyouts,(32*(-1.0)/0.25+299.5),(-15/0.25+299.5),'MMS3a',color=299
  xyouts,(32*(-1.0)/0.25+299.5),(-18/0.25+299.5),'18 mJy',color=299
  xyouts,(20*(-1.0)/0.25+299.5),(-30/0.25+299.5),'MMS3b',color=299
  xyouts,(20*(-1.0)/0.25+299.5),(-33/0.25+299.5),'16 mJy',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(-15/0.25+299.5),'MMS4',color=299
  xyouts,(-19*(-1.0)/0.25+299.5),(-18/0.25+299.5),'36 mJy',color=299

  ;add lines to labels
  oplot,[(-6*(-1.0)/0.25+299.5),(-15*(-1.0)/0.25+299.5)],[(10.5/0.25+299.5),(26.5/0.25+299.5)],color=299,linestyle=1
  oplot,[(-1.5*(-1.0)/0.25+299.5),(-18.5*(-1.0)/0.25+299.5)],[(0.5/0.25+299.5),(12/0.25+299.5)],color=299,linestyle=1
  oplot,[(-9*(-1.0)/0.25+299.5),(-18.5*(-1.0)/0.25+299.5)],[(-4/0.25+299.5),(0/0.25+299.5)],color=299,linestyle=1
  oplot,[(-9*(-1.0)/0.25+299.5),(-18.5*(-1.0)/0.25+299.5)],[(-17/0.25+299.5),(-16/0.25+299.5)],color=299,linestyle=1
  oplot,[(-2*(-1.0)/0.25+299.5),(25*(-1.0)/0.25+299.5)],[(-8/0.25+299.5),(-4/0.25+299.5)],color=299,linestyle=1
  oplot,[(8*(-1.0)/0.25+299.5),(24*(-1.0)/0.25+299.5)],[(-13.5/0.25+299.5),(-16/0.25+299.5)],color=299,linestyle=1
  oplot,[(6*(-1.0)/0.25+299.5),(16*(-1.0)/0.25+299.5)],[(-14/0.25+299.5),(-28/0.25+299.5)],color=299,linestyle=1

  
  ;add scale bar
  d=520.0
  bar_length=((0.05*3.0857d18/1.496d13)/d)/0.25
  oplot,[xmin+20,xmin+20+bar_length],[ymax-30,ymax-30],color=299
  oplot,[xmin+20,xmin+20],[ymax-30-5,ymax-30+5],color=299
  oplot,[xmin+20+bar_length,xmin+20+bar_length],[ymax-30-5,ymax-30+5],color=299
  xyouts,(25*(-1.0)/0.25+299.5),(28/0.25+299.5),'0.05 pc',color=299





  
  ;add SMA beam
  beam_x=2.91/2.
  beam_y=2.74/2.
  beam_pa=-52.1+90.
  ac=findgen(50)*(!pi*2/49.)
  beam_plot_x_unrotated=(beam_x*cos(ac))
  beam_plot_y_unrotated=(beam_y*sin(ac))
  beam_plot_x=(((beam_plot_x_unrotated*cos((90.-beam_pa)*(!pi/180.)))-(beam_plot_y_unrotated*sin((90.-beam_pa)*(!pi/180.))))*(1.0))
  beam_plot_y=((beam_plot_x_unrotated*sin((90.-beam_pa)*(!pi/180.)))+(beam_plot_y_unrotated*cos((90.-beam_pa)*(!pi/180.))))
  loadct,0
  polyfill,(beam_plot_x/0.25)+xmax-20,(beam_plot_y/0.25)+ymin+20,color=150
  loadct,0




  ;add ALMA beam
  beam_x=4.644393258625E-04/2.*3600.
  beam_y=2.193762527572E-04/2.*3600.
  beam_pa=180.-5.82
  ac=findgen(50)*(!pi*2/49.)
  beam_plot_x_unrotated=(beam_x*cos(ac))
  beam_plot_y_unrotated=(beam_y*sin(ac))
  beam_plot_x=(((beam_plot_x_unrotated*cos((90.-beam_pa)*(!pi/180.)))-(beam_plot_y_unrotated*sin((90.-beam_pa)*(!pi/180.))))*(1.0))
  beam_plot_y=((beam_plot_x_unrotated*sin((90.-beam_pa)*(!pi/180.)))+(beam_plot_y_unrotated*cos((90.-beam_pa)*(!pi/180.))))
  loadct,0
  polyfill,(beam_plot_x/0.25)+xmax-20,(beam_plot_y/0.25)+ymin+20,color=0
  loadct,0







  
  ;add SMA contours in gray
  fits_read,'HBC722_mosaic_cont13mm_rp1.fits',image,header
  sky,image,skyvalue,skyerr,/silent
  extast,header,astrom_sma
  sz=size(image) & nx=sz[1] & ny=sz[2]
  x=dindgen(nx*ny) & y=dindgen(nx*ny)
  a=dindgen(nx*ny) & d=dindgen(nx*ny)
  xnew=dindgen(nx*ny) & ynew=dindgen(nx*ny)
  image_sma_1d=dblarr(nx*ny)
  step=long(0)
  for i=0,nx-1 do begin
     for j=0,ny-1 do begin
        x[step]=i
        y[step]=j
        xy2ad,x[step],y[step],astrom_sma,temp1,temp2
        a[step]=temp1
        d[step]=temp2
        ad2xy,a[step],d[step],astrom_alma,temp1,temp2
        xnew[step]=temp1
        ynew[step]=temp2
        image_sma_1d[step]=image[i,j]
        step=step+1
     endfor
  endfor
  levels=[3,8,13,18,23,28]*skyerr
  levels_neg=(-1.0)*reverse(levels)
  colors=replicate(150,n_elements(levels))
  thick=replicate(4.0,n_elements(levels))
  colors_neg=replicate(150,n_elements(levels_neg))
  thick=replicate(4.0,n_elements(levels_neg))
  style_neg=replicate(1,n_elements(levels_neg))
  loadct,0
  contour,image_sma_1d,xnew,ynew,/irregular,/overplot,levels=levels,c_colors=colors,c_thick=thick
  contour,image_sma_1d,xnew,ynew,/irregular,/overplot,levels=levels_neg,c_colors=colors_neg,c_thick=thick_neg,c_linestyle=style_neg,/noerase



  ;add ALMA contours in black
  fits_read,'HBC722_selfcal3.image.fits',image,header
  sky,image,skyvalue,skyerr,/silent
  readcol,'hbc722_alma_contours.txt',x,y,alma_data
  levels=[5,20,50,100]*skyerr
  levels_neg=(-1.0)*reverse(levels)
  colors=replicate(0,n_elements(levels))
  thick=replicate(2.0,n_elements(levels))
  colors_neg=replicate(0,n_elements(levels_neg))
  thick=replicate(2.0,n_elements(levels_neg))
  style_neg=replicate(1,n_elements(levels_neg))
  loadct,12
  contour,alma_data,x,y,/irregular,/overplot,levels=levels,c_colors=colors,c_thick=thick
  contour,alma_data,x,y,/irregular,/overplot,levels=levels_neg,c_colors=colors_neg,c_thick=thick_neg,c_linestyle=style_neg,/noerase


  

  device,/close
  spawn,'open hbc722_alma.eps'
  stop

end


