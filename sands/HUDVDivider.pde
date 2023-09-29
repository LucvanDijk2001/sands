class HUDVDivider extends HUDItem
{
   float margin;
   
   HUDVDivider(float m)
   {
    margin = m; 
   }
   
   void Show()
   {
     stroke(globals.HUDStroke);
     line(pos.x+margin,pos.y+menu.barMargin,pos.x+margin,pos.y+menu.barMargin+menu.size.y);
   }
   
   void Update()
   {
     
   }
   
}
